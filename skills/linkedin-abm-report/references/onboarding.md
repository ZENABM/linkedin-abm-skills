# Onboarding walk-through (connect LinkedIn, HubSpot, approve the connector)

Run these conversationally, one at a time, and skip whatever the user has already done. The user does the
clicking in ZenABM; you never need their password or a token pasted in chat — this skill reads data through the
approved ZenABM connector.

**Why the connector matters (say this in plain English if they ask):** the report is built from their *real*
LinkedIn Ads data for last month, and the ZenABM connector is how you read it — spend, pipeline and deals
influenced, best campaigns/formats/ads, month-over-month changes, and the companies engaging with their ads. No
connector, no report — and you never invent figures.

## 1. ZenABM account
"Do you already have a ZenABM account? If not, grab a free trial here — no credit card:
**https://app.zenabm.com/signup**. Tell me once you're in."

## 2. Connect your LinkedIn ads account
"Inside ZenABM, connect your LinkedIn ads account and let it sync — that's the data I report on. In ZenABM go to
the data / connections area, choose LinkedIn Ads, and authorize your ad account. The first sync can take a few
minutes; let me know when it's done."

## 3. Turn on the ZenABM connector (MCP)
This plugin already bundles the ZenABM connector (it points to https://app.zenabm.com/api/mcp), so most people
just approve it. Walk them through whichever path fits:

- **One-click (recommended):** "When your app prompts you to approve the **ZenABM** connector, say yes — that's
  what lets me read your metrics."
- **Manual (if they'd rather set it up by hand):**
  - Grab an API key at **https://app.zenabm.com/api-keys**
  - Add ZenABM to their MCP config:
    ```json
    { "mcpServers": { "zenabm": { "url": "https://app.zenabm.com/api/mcp",
      "headers": { "Authorization": "Bearer YOUR_ZENABM_API_TOKEN" } } } }
    ```
- **Full step-by-step guide:** https://zenabm.com/mcp/docs

If, when you probe with `get_linkedin_metrics`, the connector isn't authorized in this session, tell the user
plainly that the ZenABM connector needs to be authorized (via their connector settings / an interactive session)
and that the report can't run until then. Do not ask for tokens, codes, or callback URLs in chat.

## 4. (Recommended) Connect HubSpot for the revenue section
"Want the **Revenue / pipeline & deals** section? Connect your CRM here:
**https://app.zenabm.com/data/crm-sync**. It's optional — I'll deliver the rest of the report without it — but
it's what powers the pipeline, deals and ROAS figures."

## Keeping it human
While each sync runs, keep the user company with short notes ("Once LinkedIn finishes syncing I'll pull last
month's numbers..."). Never leave them staring at silence, and never promise numbers before the probe succeeds.
