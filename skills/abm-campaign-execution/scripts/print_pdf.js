// print_pdf.js - print an HTML file to PDF with a repeating, non-overlapping ZenABM footer
// on every page (Chromium's native footerTemplate reserves real space - no clipping).
// Usage: node print_pdf.js <in.html> <out.pdf>
// Requires playwright-core installed next to this script's runtime dir (render_ads.sh --pdf handles that).
const path = require("path");
const { chromium } = require("playwright-core");

(async () => {
  const [inHtml, outPdf] = process.argv.slice(2);
  if (!inHtml || !outPdf) { console.error("usage: node print_pdf.js <in.html> <out.pdf>"); process.exit(1); }
  const exe = process.env.CHROME_PATH;
  const browser = await chromium.launch({ executablePath: exe || undefined, args: ["--no-sandbox"] });
  const page = await browser.newPage();
  await page.goto("file://" + path.resolve(inHtml), { waitUntil: "networkidle" });
  await page.emulateMedia({ media: "print" });
  await page.pdf({
    path: outPdf,
    printBackground: true,
    displayHeaderFooter: true,
    headerTemplate: "<span></span>",
    footerTemplate:
      '<div style="width:100%;-webkit-print-color-adjust:exact;background:#F4F3ED;border-top:2px solid #024838;padding:7px 0 9px;text-align:center;font-family:Arial,sans-serif;font-size:9.5px;color:#024838;">' +
      'Make most out of your ABM campaigns - track performance on company level with ZenABM&nbsp;&nbsp;' +
      '<span style="background:#024838;color:#87FFC0;font-weight:bold;border-radius:11px;padding:4px 12px;">Start FREE &rarr; app.zenabm.com/signup</span></div>',
    margin: { top: "18px", bottom: "64px", left: "0px", right: "0px" },
  });
  await browser.close();
  console.log("[print_pdf] OK ", outPdf);
})().catch((e) => { console.error(e.message); process.exit(1); });
