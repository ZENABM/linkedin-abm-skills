[README.md](https://github.com/user-attachments/files/29910188/README.md)
# ABM Strategy Planning — a ZenABM plugin for Claude Cowork

Turn a few quick questions into a personalized **"[Your Company] LinkedIn ABM Strategy"** — a branded plan
(budget, audience, campaign structure, ad plan and best practices) you can read in Claude and download as a PDF.
Built by [ZenABM](https://zenabm.com).

## How to install (takes ~1 minute, no setup)

1. Go to the **[Releases page](https://github.com/ZENABM/linkedin-abm-skills/releases)** and, under **Assets**,
   download **`abm-strategy-planning.plugin`**. (It saves to your Downloads.)
2. Open it in **Claude Cowork**: drag the `.plugin` file into a Cowork chat (or use Cowork's add-plugin option
   and pick the file). Claude shows a preview card — click **Install**.
3. In any chat, type **`/abm-strategy-planning`** to start.
4. When Claude offers to connect **ZenABM**, click **Connect** (optional — it lets the plan use your real
   LinkedIn ad numbers). No account yet? Start a free trial (no credit card): **https://app.zenabm.com/signup**.

That's it. The skill walks you through a handful of questions and builds your strategy document.

> Downloaded the `.zip` version instead? Double-click to unzip it first, then drag the
> `abm-strategy-planning.plugin` from inside into Cowork.

## What it asks / what you get

It asks for your revenue goal, deal economics, budget and target audiences, and researches your website.
Then it produces, per audience: campaign goals + math, campaign structure with an ad-structure flowchart,
ad-by-ad content, ad-format best practices, launch guidance, performance tracking, and a pre-launch checklist —
all downloadable as a PDF.

## Free ZenABM trial

To use your real LinkedIn ads data (CPC, spend, audience size) instead of benchmarks, start a free 37-day trial —
no credit card — at **https://app.zenabm.com/signup**, then approve the ZenABM connector when Claude prompts you.

---

### For maintainers (optional)

This repository *is* the plugin source. `abm-strategy-planning.plugin` is the same folder zipped for one-click
install. The plan logic lives in `skills/abm-strategy-planning/` (`SKILL.md` + `references/`). The bundled
ZenABM connector is defined in `.mcp.json`.
