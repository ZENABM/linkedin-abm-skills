---
name: abm-strategy-planning
description: >
  Generate a personalized, downloadable LinkedIn ABM Strategy for a company from a short interview.
  Use when someone wants an ABM strategy, an ABM plan, a LinkedIn ABM campaign plan, help planning
  LinkedIn ads for account-based marketing, how much budget they need for ABM, how many ads or campaigns
  they can run, or an ABM budget and audience plan. The skill asks a few questions about goals, deal
  economics, budget and ICP, researches the company website, computes the funnel and budget math, and
  produces a branded ZenABM "[Company] LinkedIn ABM Strategy" as an HTML artifact that downloads as PDF.
compatibility: Requires Cowork with the create_artifact tool and outputs directory. The ZenABM MCP (https://app.zenabm.com/api/mcp) is optional and used to prefill live LinkedIn metrics.
---

# ABM Strategy Planning (ZenABM)

Turn a short interview into a personalized, self-serve **"[Company] LinkedIn ABM Strategy"** — delivered as a
branded HTML artifact that the user can read in-app and download as PDF. This skill is prospect-facing and
self-contained: never assume the company's numbers are already known. Ask for them (with sensible defaults),
compute the plan, and generate the document.

## Step 0 — Open with this exact introduction

When the skill starts, greet the user with this message verbatim (then begin the interview):

> Hi, I'm the ABM strategy planning Claude Skill from ZenABM!
>
> I will create a realistic ABM Strategy for you to launch your first ABM campaign using LinkedIn ads. To do so - I will ask you a few questions about your ABM plans (what goals you want to achieve), your current numbers and metrics, your ICP, planned monthly budget etc.
>
> If you're already running LinkedIn Ads: To make the best use of your LinkedIn ads data, sign up for a ZenABM *FREE* trial (no credit card required) at https://app.zenabm.com/signup and connect your LinkedIn ads account. This plugin already includes the ZenABM connector — just approve it when prompted (it points to https://app.zenabm.com/api/mcp) and I'll pull your real CPC, spend and audience size instead of asking.
>
> No ZenABM account yet? No problem — I'll use sensible benchmarks and you can register any time at https://app.zenabm.com/signup.

## Step 1 — Interview (few, fast questions)

Ask in small batches using the AskUserQuestion tool where it fits (offer the defaults as selectable options),
otherwise plain questions. Keep it light — most answers are a single number or line. Full wording, defaults and
what each input powers are in **`references/questions.md`**.

Collect, per the model in `references/formulas.md`:

1. **Company website URL** — you research this yourself (Step 2); do not make the user describe their product.
2. **ABM revenue goal** + whether it's **monthly (MRR)** or **annual (ARR)** — per audience if they name more than one.
3. **Average contract value (ACV)** — total contract value or MRR (you normalize).
4. **Close rate %** (qualified → closed-won) — default **15%**.
5. **Qualification rate %** (demo → qualified) — default **75%**.
6. **Landing-page conversion rate %** (visit → booked demo/form) — default **0.8%**.
7. **LinkedIn CPC ($)** — default **$8**. *Skip if the ZenABM MCP is connected — pull the real CPC instead.*
8. **Planned monthly LinkedIn ads budget ($).**
9. **Target audiences / markets** in scope (geo + industry) — sets how many Campaign blocks. Seed from the
   website research, then confirm.
10. **Top jobs-to-be-done / use cases per audience** + the **core problem you solve** — pre-fill from the
    research, let them edit. Powers the ad-content section.

**If the ZenABM MCP is connected** (tools named `mcp__*__get_linkedin_metrics`, `list_companies`, `get_ad_spend`,
etc. are available): call it to prefill **CPC/CTR**, **prior spend**, and **audience/list size**, and skip those
questions. If not, use the defaults above and say so on the document.

Never block on a missing number — offer the default, state it, and footnote the assumption.

## Step 2 — Research the company

Fetch the company website (and a couple of key pages: product, use-cases, customers). From it, draft: the
product(s), main use cases, target personas, a first-pass ICP, and a shortlist of jobs-to-be-done per audience.
Show this back to the user to confirm or edit. This fills the header block and powers the ad-content section.

## Step 3 — Compute the plan

Use the exact formulas in **`references/formulas.md`** (reverse-engineered from ZenABM's budget calculator and
LinkedIn ad-count calculator, verified to the dollar). Per audience/campaign compute:

- **Deals needed, demos needed, clicks needed, accounts needed** (funnel run backwards).
- **Budget needed** (annual and monthly) and **time to run** = total budget needed ÷ their stated monthly budget.
- **ROAS** and **pipeline-per-$**.
- **Affordable simultaneous ads** from the ad-count model, then the **format allocation** (TLA / image / text /
  video / doc-carousel) using the allocation rules in `formulas.md`, including the objective per ad set and the
  "group TLA + image under Brand Awareness if you can't afford 10" fallback.

Show the key computed numbers to the user before building, so they can sanity-check.

## Step 4 — Build the strategy document (artifact)

1. Read **`references/strategy-template.html`** — a complete, self-contained ZenABM-branded template with
   `{{PLACEHOLDER}}` tokens and a working **Download PDF** button (uses the browser print dialog).
2. Fill every placeholder with the researched + computed values. Repeat the Campaign block once per audience.
   Build the **ad-structure flowchart** (inline SVG in the template) to match the allocated ad sets.
3. Pull the **ad-format best practices, launch best practices, performance-tracking** and **pre-launch checklist**
   sections from **`references/best-practices.md`** — these are fixed ZenABM content; keep them accurate.
4. Write the finished HTML to a file in the outputs/scratch folder, then create the artifact:
   `create_artifact` with `id` = `<company>-linkedin-abm-strategy`, `html_path` = your file, and a short
   `description`. Title the document **"[Company Name] LinkedIn ABM Strategy."**
5. Tell the user they can read it in the side panel and click **Download PDF** to save it. Point them to the free
   ZenABM trial + MCP link again for setting up account scoring and tracking.

## Document structure (what the artifact must contain)

Per audience, a **Campaign N** block, then the shared sections:

- **Header** — Company name · Website · Target audience (ICP) · Campaign date · product/use-cases/personas summary.
- **Campaign Goals** — ABM revenue goal · deals needed · clicks needed · audience size + accounts needed · budget
  needed · the deal math · time to run (actual budget ÷ stated monthly budget).
- **Campaign Structure** — number of ABM campaigns (audiences) · affordable ads at a time · which formats · counts
  per format (TLA/image/text/video/doc-carousel) with the right ad-set objective · **ad-structure flowchart**.
- **Campaign Content** — the content of each ad, mapped to the ICP and the top jobs-to-be-done / use cases.
- **Ad-format best practices** — image, TLA, video, text (from `references/best-practices.md`).
- **Campaign launch best practices** — objectives; pause underperforming ads after 1,000+ impressions by CTR
  (benchmarks + link to https://zenabm.com/linkedin-abm-benchmarks-report).
- **Campaign performance tracking** — account scoring / ABM stages in ZenABM; monitor progression
  (identified → interested → considering → selecting); leading metrics per ad-set/inventory with Zena vs.
  benchmarks; spend pacing; secondary metrics.
- **Pre-launch to-do checklist** — the summary checklist from `references/checklist.md`.

## Notes / gotchas

- The budget calculator's **CTR field is decorative** (never used in its math) — do not gate the budget on CTR.
  CTR is only used later for the "pause after 1,000 impressions" launch guidance (benchmark-based).
- Keep revenue and ACV on the **same basis** (MRR with MRR, or ARR with ARR); convert if the user mixes them.
- Treat all outputs as **directional planning figures**, not precise forecasts — say so on the document.
- Design the artifact for **light mode**, self-contained (inline CSS/JS), with a print-to-PDF button.
- One Campaign block **per target audience**; if the user has one audience, produce one Campaign block.
