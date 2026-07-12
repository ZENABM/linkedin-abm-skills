# 💚 LinkedIn ABM Skills by ZenABM

> ✨ Plan it, design it, run it, prove it — a complete LinkedIn ABM toolkit for Claude.

Four AI skills from [ZenABM](https://zenabm.com/) that help you **strategize, design, audit, and report** on your
LinkedIn account-based-marketing campaigns — each one turning your real data into a polished, shareable document
in minutes. No spreadsheets, no guesswork. 🚀

Built as portable **[Agent Skills](https://code.claude.com/docs/en/skills)** (a `SKILL.md` + its resources per
skill) and bundled as one **Claude Code plugin**, so you can install all four with a single command or drop any
one into Claude on the web or desktop.

---

## 🚀 The four skills

| | Skill | What you get |
|---|---|---|
| 🧭 | **[`abm-strategy-planning`](skills/abm-strategy-planning/)** | A personalized LinkedIn ABM **strategy** — budget, audience, and campaign plan. |
| 🎨 | **[`abm-campaign-execution`](skills/abm-campaign-execution/)** | **Launch-ready ad creative** — copy, briefs, and designed mockups. |
| 🔍 | **[`linkedin-abm-audit`](skills/linkedin-abm-audit/)** | A **30-day audit** of your live ads with a clear, prioritized fix-list. |
| 📊 | **[`linkedin-abm-report`](skills/linkedin-abm-report/)** | A shareable, exec-ready **monthly performance report**. |

## 🧩 The full ABM journey, covered

```
🧭 Strategy  →  🎨 Design  →  🚀 Launch  →  🔍 Audit  →  📊 Report
```

Use them together to run ABM end to end, or reach for just the one you need today. 🙂

---

## 🧭 ABM Strategy Planning
**Know exactly how to launch — before you spend a dollar.** Answer a few questions about your goals, budget, and
ideal customers, and get a realistic, personalized LinkedIn ABM strategy built on real benchmarks.

**You get:** a branded **strategy document (PDF)** with your recommended budget, the audience size you need,
your campaign structure, an ad plan mapped to your buyers, and launch best practices — so you start with a plan
that actually adds up.

## 🎨 ABM Campaign Ad Design
**Turn your strategy into ads you can launch this week.** It takes your plan and produces the creative and the
briefs for you — no blank-page paralysis, no waiting on design.

**You get:** a clear campaign outline, ready-to-use **ad copy and creative briefs** for each ad, and **designed
ad mockups you can upload straight to LinkedIn** — all written to what actually performs in B2B ABM.

## 🔍 ABM Audit
**Find out if your ad spend is working — and exactly what to fix.** It reviews your last 30 days of live LinkedIn
ads and grades them against ZenABM's B2B benchmarks.

**You get:** a branded **audit (PDF)** that scores your spend, tells you whether you're running the right number
of ads, shows which formats and ads are winning (and which are wasting budget), which accounts are worth chasing,
and hands you a **prioritized list of fixes** ranked by impact.

## 📊 ABM Monthly Report
**A month-end report your whole team can read — done for you.** It summarizes last month's LinkedIn ABM
performance and compares it to the month before.

**You get:** a shareable, exec-ready **monthly report (PDF)** covering pipeline and deals influenced, spend,
your best campaigns and ad formats, the companies engaging most with your ads (and which are showing buying
signals), and clear next steps. 🗓️ Set it to arrive **automatically on the 1st of every month**.

---

## ▶️ Install

Pick the way you use Claude. 👇

### Option A — Claude Code (all four skills, one command)

Add this repo as a plugin marketplace, then install the plugin:

```
/plugin marketplace add ZENABM/linkedin-abm-skills
/plugin install linkedin-abm-skills@zenabm
```

All four skills become available. Start one from any chat — e.g. `/linkedin-abm-report` — or just ask in plain
English: *"Build my monthly LinkedIn ABM report."* The ZenABM connector is bundled; approve it when prompted to
use your real data.

### Option B — Claude app · Cowork / desktop (one file, no setup)

Each skill also ships as a single-file installer on the [**Releases**](../../releases) page:

1. Open a skill's release and download its file from **Assets** (a `.skill` or `.plugin` file).
2. Drag the file into a Claude chat and click **Save skill** / **Install**.
3. Start it with its slash command (e.g. `/abm-strategy-planning`) or just ask in plain English.

### Option C — Claude.ai (web) or manual Claude Code

Clone the repo and copy the skill folder you want:

```bash
git clone https://github.com/ZENABM/linkedin-abm-skills.git
# Claude Code — copy one skill (or all of skills/) into your skills directory:
cp -r linkedin-abm-skills/skills/linkedin-abm-audit ~/.claude/skills/
# For a single project, use .claude/skills/ inside that project instead.
```

On **Claude.ai**, add the skill folder's files to a Project (or upload the release `.skill` file), then ask for
what you need.

---

## 🆓 Use your real numbers (free ZenABM trial)

These skills shine with your **real** LinkedIn ads data — spend, CPC, audience size, pipeline. Start a free
trial (no credit card) at **https://app.zenabm.com/signup** and approve the ZenABM connector when Claude asks.
No account yet? The skills still work with smart benchmarks. Prefer a walkthrough? 📅 **Book a demo:**
https://zenabm.com/book-a-demo

---

## 🗂️ Repository structure

```
.
├── README.md                     # you are here
├── CLAUDE.md                     # routing + operating principles for the skills
├── LICENSE                       # MIT
├── .mcp.json                     # ZenABM data connector (shared by all skills)
├── .claude-plugin/
│   ├── plugin.json               # one plugin, bundles the four skills
│   └── marketplace.json          # makes this repo an installable marketplace
└── skills/
    ├── abm-strategy-planning/    # SKILL.md + references/
    ├── abm-campaign-execution/   # SKILL.md + references/ + assets/ + scripts/ + evals/
    ├── linkedin-abm-audit/       # SKILL.md + references/ + assets/
    └── linkedin-abm-report/      # SKILL.md + references/ + assets/
```

Every folder under `skills/` is a standard Agent Skill: a `SKILL.md` with a `name`/`description` frontmatter
plus the references, templates and scripts it needs. See [`CLAUDE.md`](CLAUDE.md) for when to use which skill.

---

📈 **2026 LinkedIn ABM Benchmarks Report:** https://zenabm.com/linkedin-abm-benchmarks-report
💚 Built with **[ZenABM](https://zenabm.com/)** — track your ABM performance on the company level.
