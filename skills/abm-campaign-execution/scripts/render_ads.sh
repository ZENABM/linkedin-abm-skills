#!/usr/bin/env bash
# render_ads.sh - render LinkedIn ad mockup HTML files to 1080px PNGs with headless Chromium.
# Works in sandboxes WITHOUT root: installs Playwright's Chromium, then fetches any missing
# system libraries via `apt-get download` + `dpkg-deb -x` into a user-writable dir.
#
# Usage:
#   ./render_ads.sh <file.html | directory> [out-dir] [size]
#     file/dir : one HTML file, or a directory whose *.html files all get rendered
#     out-dir  : where PNGs go (default: alongside the HTML)
#     size     : CSS pixel size of the square ad (default 540; PNG is 2x = 1080)
#
# Landscape ads: name the file *.wide.html -> rendered at 1200x628 CSS px (2400x1256 PNG... capped 2x).
set -uo pipefail

# PDF mode: render_ads.sh --pdf <file.html> <out.pdf>   (for the outline artifact etc.)
PDF_MODE=0
if [ "${1:-}" = "--pdf" ]; then PDF_MODE=1; shift; fi

IN="${1:?usage: render_ads.sh [--pdf] <file.html|dir> [out|out-dir] [size]}"
OUTDIR="${2:-}"
SIZE="${3:-540}"

WORK="$HOME/.adrender"
LIBS="$WORK/libs"
mkdir -p "$WORK" "$LIBS"

# ---------- 1. ensure Chromium ----------
find_chrome() { ls -d "$HOME"/.cache/ms-playwright/chromium-*/chrome-linux/chrome 2>/dev/null | sort | tail -1; }
CHROME="$(find_chrome || true)"
if [ -z "${CHROME:-}" ]; then
  echo "[render_ads] installing Playwright Chromium (one-time)..."
  npx -y playwright install chromium >/dev/null 2>&1 || npx -y playwright install chromium
  CHROME="$(find_chrome)"
fi
[ -n "$CHROME" ] || { echo "[render_ads] ERROR: could not install Chromium"; exit 1; }

# ---------- 2. ensure system libs (no root needed) ----------
export LD_LIBRARY_PATH="$LIBS/usr/lib/$(uname -m)-linux-gnu:$LIBS/lib/$(uname -m)-linux-gnu:${LD_LIBRARY_PATH:-}"
missing_libs() { ldd "$CHROME" 2>/dev/null | awk '/not found/{print $1}'; }
if [ -n "$(missing_libs)" ]; then
  echo "[render_ads] fetching missing system libs without root..."
  PKGS="libxdamage1 libxfixes3 libxcomposite1 libxrandr2 libgbm1 libxkbcommon0 libasound2 \
        libatk1.0-0 libatk-bridge2.0-0 libcups2 libnss3 libnspr4 libatspi2.0-0 libdrm2 \
        libwayland-client0 libx11-xcb1 libxcursor1 libxi6 libpangocairo-1.0-0"
  ( cd "$WORK" && apt-get download $PKGS >/dev/null 2>&1
    for d in *.deb; do [ -f "$d" ] && dpkg-deb -x "$d" "$LIBS" && rm -f "$d"; done )
fi
LEFT="$(missing_libs)"
if [ -n "$LEFT" ]; then
  echo "[render_ads] still missing: $LEFT"
  echo "[render_ads] try: cd $WORK && apt-get download <pkg-for-each-lib> && dpkg-deb -x *.deb $LIBS"
  exit 1
fi

# ---------- 3. render ----------
if [ "$PDF_MODE" = 1 ]; then
  OUT="${OUTDIR:-${IN%.html}.pdf}"
  # Use Playwright's native footerTemplate: it reserves real space on every page,
  # so the ZenABM footer can never clip or overlap body text.
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  if [ ! -d "$WORK/node_modules/playwright-core" ]; then
    ( cd "$WORK" && npm init -y >/dev/null 2>&1; npm install playwright-core --silent >/dev/null 2>&1 )
  fi
  IN_ABS="$(cd "$(dirname "$IN")" && pwd)/$(basename "$IN")"
  case "$OUT" in /*) ;; *) OUT="$PWD/$OUT";; esac
  NODE_PATH="$WORK/node_modules" CHROME_PATH="$CHROME" node "$SCRIPT_DIR/print_pdf.js" "$IN_ABS" "$OUT"
  [ -s "$OUT" ] && { echo "[render_ads] OK  $OUT"; exit 0; } || { echo "[render_ads] FAIL pdf $IN"; exit 1; }
fi

render_one() {
  local html="$1" out="$2" w="$3" h="$4"
  "$CHROME" --headless=new --no-sandbox --disable-gpu --hide-scrollbars \
    --force-device-scale-factor=2 \
    --window-size="${w},${h}" \
    --screenshot="$out" \
    --virtual-time-budget=8000 \
    "file://$(cd "$(dirname "$html")" && pwd)/$(basename "$html")" 2>/dev/null
  if [ -s "$out" ]; then echo "[render_ads] OK  $out"; else echo "[render_ads] FAIL $html"; return 1; fi
}

FAIL=0
render_path() {
  local html="$1"
  local base; base="$(basename "$html" .html)"
  local dir; dir="${OUTDIR:-$(dirname "$html")}"; mkdir -p "$dir"
  local w="$SIZE" h="$SIZE"
  case "$base" in *.wide) w=1200; h=628;; esac
  render_one "$html" "$dir/${base}.png" "$w" "$h" || FAIL=1
}

if [ -d "$IN" ]; then
  found=0
  for f in "$IN"/*.html; do [ -e "$f" ] || continue; found=1; render_path "$f"; done
  [ "$found" = 1 ] || { echo "[render_ads] no .html files in $IN"; exit 1; }
else
  render_path "$IN"
fi
exit $FAIL
