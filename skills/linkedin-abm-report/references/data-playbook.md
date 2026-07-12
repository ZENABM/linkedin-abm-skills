# Data playbook — monthly report (which ZenABM MCP tool for each section)

Tool names are shown unprefixed (e.g. `get_creative_performance`); at runtime they are
`mcp__<zenabm-server>__<name>` — match by the trailing name. Two windows matter everywhere:

- **month** = the last full calendar month (report month).
- **prev** = the calendar month before it (comparison).

Compute the boundaries from today's date. Example (today 2026-07-11): month = 2026-06-01…2026-06-30,
prev = 2026-05-01…2026-05-31. Pass **explicit `startDate`/`endDate`** so the boundaries are exact (you may use
`period:"lastMonth"` for the report month, but always pass explicit dates for `prev`).

**Probe first:** `get_linkedin_metrics` for the report month. Empty/error → connector not ready; stop and help
connect. Never invent numbers.

## Executive summary (assembled from the sections below — pull once, reuse)
- Totals for month and prev: `get_linkedin_metrics` (spend, impressions, clicks, engagements) and `get_ad_spend`
  (`summary` + `byAdSet`). Derive CPC, CPM, CTR, effective CTR/CPC to LP (`metrics.md`).
- Pipeline generated + deals open: `list_deals` (see §Revenue). Skip pipeline figures if no CRM.

## Revenue, pipeline & deals (needs CRM/HubSpot) — SKIP if not connected
- `list_deals` with `dateFrom`/`dateTo` = the report month; also `influenceFilter` / `abmCampaigns` as needed.
  Read `amount`, `stage`, `linkedinInfluenced`, `abmInfluenced`, `campaigns[]`, and the
  `impressionsBeforeDeal` / `clicksBeforeDeal` / `engagementsBeforeDeal` fields.
- **Pipeline generated** = sum of `amount` on open + won LinkedIn/ABM-influenced deals created/closed in the month;
  **deals open** = count of non-closed influenced deals. Compute pipeline-per-$ and ROAS from spend.
- If `list_deals` is empty or no CRM is connected: **omit the whole Revenue section and the pipeline stat cards**,
  and show the crm-sync connect prompt (https://app.zenabm.com/data/crm-sync). Don't guess pipeline.

> **RULE — quarantine test / sandbox deals.** Dev/sandbox orgs seed fake, usually-large opps that otherwise
> dominate "pipeline." Exclude (or clearly label "test/demo") any deal whose `externalUrl` points at a
> sandbox/dev host (`develop.my.salesforce.com`, `sandbox`, `--dev`, `orgfarm`, `test`), whose name/company is a
> placeholder (`Acme`, `Test`, `Demo`, `OPPORTUNITY TEST`), whose company doesn't match the account it's filed
> under, or that shows a round outsized amount on an account with barely any real engagement. Prefer production
> HubSpot deals over Salesforce dev-org rows. Base headline pipeline on real deals only.

## Campaign performance
- `list_campaigns` for month and prev → per-campaign impressions, clicks, engagements, cost, CPC, CTR; compute MoM
  deltas. Rank best/worst; identify the best campaign *type*.
- `list_abm_campaigns` + `get_abm_campaign_overview`, combined with `list_deals` (`abmCampaigns`), → the **top ABM
  campaign by pipeline/deals**. The **top LinkedIn campaign** is the best `list_campaigns` row by
  pipeline→clicks→efficiency.

## Ad performance (split by inventory type / ad format)
- `get_creative_performance` with `groupBy:"format"` for month AND prev → one row per format (impressions, clicks,
  landingPageClicks, cost, engagements). This is the backbone of the ad-format table, spend-per-format, and the
  benchmark grade.
- Best/worst individual ads: `get_creative_performance` month, `sortBy:"clicks"` DESCENDING then ASCENDING; use
  `adFormat:"TLA"` for TLA effective CTR / effective spend.

> **RULE — classify ads by `adFormat` / `format`, never by campaign or ad-set NAME.** A campaign named "TLA" can
> hold Single Image ads. Read the real format (`TLA`, `STANDARD_UPDATE`=Single Image, `SINGLE_VIDEO`, `CAROUSEL`,
> `SPONSORED_UPDATE_NATIVE_DOCUMENT`=Document, `TEXT_AD`, `SPOTLIGHT`) and, when naming a campaign, state the
> format its ads actually are.

> **RULE — grade link-driving formats on effective CPC to LP, not raw CPC.** For Single Image, Carousel and Video,
> the deciding cost metric is `cost / landingPageClicks` vs the format's effective-CPC-to-LP benchmark
> (`benchmarks.md`). Raw CPC is secondary context; TLAs get both.

## Ad spend (pie + allocation)
- Reuse the `groupBy:"format"` totals: spend per format and % of total. Build the **inline SVG donut/pie** from
  those shares (do NOT rely on Chart.js — it won't render in the PDF export; an SVG renders in both the artifact
  and the PDF). Then judge allocation: is spend concentrated in a weak-effective-CPC-to-LP format while a strong
  one (usually TLAs) is underfunded? If so, recommend a concrete re-allocation with a target split.

## Top engaged companies
- **Top ~15 engaged:** `list_companies` month, `sortBy:"engagements"` DESCENDING, `pageSize:15`. Capture name,
  impressions, clicks, engagements and `abmStage` / `lifetimeAbmStage`. Skip obvious placeholder aggregates
  (e.g. a row literally named "Various Startups" with NULL website).
- **Companies with 3+ clicks (likely "Interested"):** make a SECOND call, `sortBy:"clicks"` DESCENDING,
  `pageSize:20`, and keep every company with `clicks >= 3`. Three-plus clicks in one month is a strong buying
  signal — list these as the accounts to route to sales, and pair them with the "set your ABM stage" CTA.
- Optional context: `list_abm_stages` + `get_abm_stage_companies_entering` (Interested stage, month) for accounts
  that warmed up during the month. `includeWeekly:true` adds intra-month surge context.

## Next steps — to implement next month
- Derived from the above (no new calls): scale the top campaign/format, reallocate off the weakest
  effective-CPC-to-LP format, refresh fatigued creatives, route the top engaged / newly-interested accounts to
  sales. Keep it forward-looking and concrete.

## Efficiency
- Prefer `groupBy:"format"` and account/campaign-level tools over per-ad loops. Respect page sizes (max 100);
  paginate only until you have enough for the top-N lists.
