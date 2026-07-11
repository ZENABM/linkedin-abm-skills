# 💚 LinkedIn ABM Skills by ZenABM

> ✨ Plan it, build it, launch it, measure it — a full LinkedIn ABM toolkit for Claude Cowork & Claude Code.

A family of Claude skills (and one plugin) from [ZenABM](https://zenabm.com/) that take you across the whole
account-based-marketing journey on LinkedIn: **strategy → creative → audit → monthly reporting** — each one
branded, benchmark-backed, and downloadable as a polished PDF. 🚀

---

## 🚀 Releases — grab what you need

Every skill ships as its own release. Download the asset, install in ~1 minute, and go. 👇

| | Release | What it's for |
|---|---|---|
| 🔍 | **[LinkedIn ABM Audit](https://github.com/ZENABM/linkedin-abm-skills/releases/tag/LinkedIn_ABM_Audit_v1)** | Audit your **last 30 days** of live LinkedIn ads and get a prioritized fix-list. |
| 🧭 | **[LinkedIn ABM Strategy Planning](https://github.com/ZENABM/linkedin-abm-skills/releases/tag/LinkedIn_ABM_Strategy_Planning_plugin)** | Turn a few questions into a personalized **ABM strategy** (budget, audience, campaign plan). *Plugin.* |
| 🎨 | **[LinkedIn ABM Campaign Ad Design (Briefs + Designs)](https://github.com/ZENABM/linkedin-abm-skills/releases/tag/abm_campaign_execution_v1.0)** | Turn a strategy into **launch-ready** briefs + on-brand ad mockups (HTML + PNG). |
| 📊 | **[LinkedIn ABM Campaign Monthly Report](https://github.com/ZENABM/linkedin-abm-skills/releases/tag/LinkedIn_ABM_Campaign_Monthly_REPORT_v1)** | A shareable, exec-ready **monthly report** for the last calendar month, month-over-month. |

## 🧩 How it all fits together

```
🧭 Strategy  →  🎨 Ad Design  →  🚀 Launch  →  🔍 Audit (every 30 days)  →  📊 Report (every month)
```

Start with **Strategy Planning** to shape the plan, use **Ad Design** to produce the creative, then keep it
healthy with the **Audit** (diagnostic, trailing 30 days) and the **Monthly Report** (stakeholder recap of the
last calendar month). Mix and match — each one works on its own too. 🙂

---

## 🔍 1 · LinkedIn ABM Audit
📦 **[Download / release →](https://github.com/ZENABM/linkedin-abm-skills/releases/tag/LinkedIn_ABM_Audit_v1)**

Audits a company's **live LinkedIn ads and ABM performance** from the **last 30 days** of spend and hands back a
branded, downloadable **"[Company] LinkedIn Ads & ABM Audit"** (HTML + PDF) with a prioritized fix list. It pulls
real spend, CPC, CPM, CTR, ad count, format mix, deal influence, campaign trends and account engagement via the
ZenABM MCP, grades every format against ZenABM's 2026 B2B SaaS benchmarks, and tells you exactly what to fix.

You get a scorecard, an "are you running the right number of ads?" check, spend-by-format, deal influence,
a ✓/✗ benchmark grade per format (link formats judged on **effective CPC to landing-page click**), budget
re-allocation, campaign trends, ad insights, red/green flags, and a ranked fix list.

🖱️ **Install:** download `linkedin-abm-audit.zip`, unzip, double-click `linkedin-abm-audit.skill` → **Save skill**.
Then run **`/linkedin-abm-audit`** or ask *"Audit my LinkedIn ads."*

## 🧭 2 · LinkedIn ABM Strategy Planning *(plugin)*
📦 **[Download / release →](https://github.com/ZENABM/linkedin-abm-skills/releases/tag/LinkedIn_ABM_Strategy_Planning_plugin)**

Turns a few quick questions into a personalized **"[Your Company] LinkedIn ABM Strategy"** — a branded plan with
budget, audience, campaign structure, an ad-structure flowchart, ad-by-ad content, best practices, launch
guidance, performance tracking and a pre-launch checklist — readable in Claude and downloadable as a PDF. It asks
for your revenue goal, deal economics, budget and target audiences, researches your website, and does the funnel
+ budget math for you.

🖱️ **Install (this one is a *plugin*):** from the release Assets, download `abm-strategy-planning.plugin`, then
**drag the `.plugin` file into a Cowork chat** (or Cowork's add-plugin option) and click **Install**. Then type
**`/abm-strategy-planning`** to start. *(Downloaded the `.zip` instead? Unzip first, then drag the `.plugin` from
inside.)*

## 🎨 3 · LinkedIn ABM Campaign Ad Design (Briefs + Designs)
📦 **[Download / release →](https://github.com/ZENABM/linkedin-abm-skills/releases/tag/abm_campaign_execution_v1.0)**

The execution follow-up to Strategy Planning: takes the strategy you already built and turns it into
**launch-ready campaign assets — in one run.** ✨

- 🗂️ **Outline first, as an artifact** — delivers `00-ABM-Campaign-Outline` (Markdown + styled HTML with a Download
  PDF button + a pre-rendered PDF) *before* any briefs are written, so you can correct the plan early. Every ad
  row deep-links to its brief and mockup.
- 📝 **One briefs document, not 24 files** — `01-Ad-Briefs.md` (+ `.docx`) with a linked table of contents and one
  anchored section per ad: copy brief, design brief, macro variants, and the exact image files each ad needs.
- 🖼️ **Rendered mockups you can upload** — each image ad ships as an editable self-contained `.html` and a
  1080×1080 `.png`, built on 23 proven B2B ad design patterns with face-safe cropping.
- 🧠 **Benchmark-backed TLAs** — written to the 2026 LinkedIn ABM Benchmarks rules (1st-person voice, pain-point
  hook, 1,000–1,500 chars, link in the bottom 25%, no webinar CTAs), with an anti-slop filter on every word.
- 🗄️ **Optional Notion database** — duplicates ZenABM's campaign-management template and fills one page per ad.
- 🎨 **ZenABM-branded PDF** — logo top bar and a "track performance on company level with ZenABM · Start FREE"
  footer on every page.

🖱️ **Install:** download `abm-campaign-execution.skill` (single file — the whole skill), drag it into a Claude
chat → **Save skill**. Then say **`/abm-campaign-execution`** or *"turn my ABM strategy into campaigns."*
Best run after `/abm-strategy-planning`.

## 📊 4 · LinkedIn ABM Campaign Monthly Report
📦 **[Download / release →](https://github.com/ZENABM/linkedin-abm-skills/releases/tag/LinkedIn_ABM_Campaign_Monthly_REPORT_v1)** · 🆕 *latest*

Builds a **monthly report** for the last full **calendar month** (with a month-over-month comparison) — a
shareable, exec-ready **"[Company] LinkedIn ABM Ad Report — [Month Year]"** as HTML + PDF. 📄 It grades everything
against ZenABM's 2026 benchmarks and finishes with recommendations and next steps.

Includes a table of contents, an executive summary, revenue/pipeline/deals (skipped with a connect prompt if no
CRM), an **ad-spend pie chart** with an allocation verdict, campaign performance, ad performance by inventory type
(✓/✗ vs benchmark + the full six-format table with dwell time), a full **Top Engaged Companies** section with a
**"3+ clicks — likely Interested"** list, and next steps. 🗓️ It's designed to run **automatically on the 1st of
each month** — the first report is free on the ZenABM trial, and continuing needs an active subscription.

🖱️ **Install:** download `linkedin-abm-report.zip`, unzip, double-click `linkedin-abm-report.skill` → **Save
skill**. Then run **`/linkedin-abm-report`** or ask *"Build my monthly LinkedIn ABM report."*

---

## ✅ Requirements (all skills)

- 🖥️ Claude **Cowork** (or Claude Code) with the artifact + outputs tools. Campaign Ad Design also needs shell
  access (Node + Python — default in Cowork).
- 🔌 The **ZenABM MCP** connected and authorized: `https://app.zenabm.com/api/mcp`
- 🧾 Optional but recommended: connect **HubSpot / your CRM** in ZenABM
  (https://app.zenabm.com/data/crm-sync) for deal-influence and revenue sections.

## 🆓 Free ZenABM trial

To use your **real** LinkedIn ads data (CPC, spend, audience size, pipeline) instead of benchmarks, start a free
trial — no credit card — at **https://app.zenabm.com/signup**, then approve the ZenABM connector when Claude
prompts you. Prefer a walkthrough? 📅 **Book a demo:** https://zenabm.com/book-a-demo

## 🗂️ Repo layout

```
skills/linkedin-abm-audit/       audit skill source (SKILL.md + references/ + assets/)
skills/linkedin-abm-report/      monthly report skill source
dist/                            packaged, installable bundles
```

*(The Strategy Planning plugin and Campaign Ad Design skill are published via their own releases.)*

---

📈 **2026 LinkedIn ABM Benchmarks Report:** https://zenabm.com/linkedin-abm-benchmarks-report
💚 Built with **[ZenABM](https://zenabm.com/)** — track your ABM performance on the company level.
