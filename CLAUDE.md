# LinkedIn ABM Skills — operating guide

This repository is a collection of four **Agent Skills** by [ZenABM](https://zenabm.com) that run a
LinkedIn account-based-marketing (ABM) program end to end: **plan it, design it, audit it, report it.**
Each skill is self-contained (`SKILL.md` + its own `references/`, `assets/`, `scripts/`) and lives under
`skills/`. They are packaged together as one Claude Code plugin and share the ZenABM data connector
(`.mcp.json`).

> **Note on loading:** Claude Code does not load a plugin-root `CLAUDE.md` as context — plugins contribute
> context through their skills. This file is documentation for humans and for anyone who opens the repo
> directly as a project. Each skill routes itself through the `description` in its own `SKILL.md`; the table
> below just makes that routing legible in one place.

## The skills

| Skill | Use it when the user wants to… | Core deliverable |
|---|---|---|
| [`abm-strategy-planning`](skills/abm-strategy-planning/SKILL.md) | plan a **new** campaign, size a budget, decide how many ads/campaigns to run, before spending | A branded **"[Company] LinkedIn ABM Strategy"** (HTML → PDF): budget math, audience sizing, campaign structure, ad plan, best practices |
| [`abm-campaign-execution`](skills/abm-campaign-execution/SKILL.md) | **execute** a finished strategy — build the actual ads, briefs and mockups | A campaign outline, one briefs document per ad, on-brand image-ad mockups (HTML + PNG), optional Notion database |
| [`linkedin-abm-audit`](skills/linkedin-abm-audit/SKILL.md) | **audit / grade / fix** their own LIVE ads from the last 30 days of spend | A branded **"[Company] LinkedIn Ads & ABM Audit"** (HTML → PDF) with a prioritized fix list |
| [`linkedin-abm-report`](skills/linkedin-abm-report/SKILL.md) | a **monthly** performance report for the last full calendar month, month-over-month | A shareable **"[Company] LinkedIn ABM Ad Report — [Month Year]"** (HTML → PDF) |

## The ABM journey

```
Strategy  →  Design  →  Launch  →  Audit  →  Report
(plan)       (execute)   (LinkedIn)  (fix)     (recap)
```

Skills feed into each other: strategy decides *what to run*, execution decides *what each ad says and looks
like*, audit grades what's live, report recaps the month. Use them together, or reach for the one that
matches the request.

### Routing (do-not-confuse)

- **Plan a new campaign / budget** → `abm-strategy-planning` (not audit/report — nothing is live yet).
- **Build the ads from a plan** → `abm-campaign-execution` (needs a strategy in the conversation first).
- **"Are my live ads any good / what do I fix"** (trailing 30 days) → `linkedin-abm-audit`.
- **"Report on last month"** (full calendar month, MoM) → `linkedin-abm-report`.

## Operating principles

1. **Use real data when connected.** All four skills read live LinkedIn spend, CPC/CPM/CTR, audience size,
   pipeline and account engagement through the **ZenABM MCP** (`https://app.zenabm.com/api/mcp`, bundled in
   `.mcp.json`). Prefer real numbers over benchmarks; fall back to benchmarks and say so on the document.
2. **Never fabricate.** Do not invent metrics, TLA authors, customer stories or a strategy. Ask, or pull from
   ZenABM. State assumptions and footnote defaults.
3. **Deliver a downloadable artifact.** Every skill produces a branded, self-contained HTML document with a
   Download-PDF button. Design for light mode; inline CSS/JS.
4. **Follow the skill, in order.** Each `SKILL.md` is the source of truth for its steps, formulas and
   templates. Work through multi-step skills sequentially — present, get feedback, advance; don't dump
   everything at once.
5. **Treat outputs as directional planning figures,** not precise forecasts — say so on the document.

## ZenABM connector

The skills work with smart benchmarks and no account, but shine with the user's real data. To connect:
start a free trial (no credit card) at **https://app.zenabm.com/signup** and approve the ZenABM connector
when Claude prompts. The connector is defined once at the repo root in `.mcp.json` and shared by every skill.

## Repository layout

```
.
├── README.md                     # front door: what each skill does + how to install
├── CLAUDE.md                     # this file: routing + operating principles
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
