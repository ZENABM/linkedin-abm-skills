# Onboarding walk-through (connect LinkedIn, HubSpot, approve the connector)

Run these conversationally, one at a time, and skip whatever the user has already done. The user does the
clicking in ZenABM; you never need their password or a token pasted in chat — this skill reads data through the
approved ZenABM connector, not a token.

## 1. ZenABM account
"Do you already have a ZenABM account? If not, grab a free trial here — no credit card:
**https://app.zenabm.com/signup**. Tell me once you're in."

## 2. Connect your LinkedIn ads account
"Inside ZenABM, connect your LinkedIn ads account and let it sync — that's the data I audit. In ZenABM go to the
data / connections area, choose LinkedIn Ads, and authorize your ad account. The first sync can take a few
minutes; let me know when it's done."

## 3. Approve the ZenABM connector (MCP)
"This plugin already includes the ZenABM connector (it points to https://app.zenabm.com/api/mcp). When your app
prompts you to approve it, say yes — that's what lets me read your metrics. If it isn't authorized yet, it needs
approving in your connector settings; I can't do that step for you, but ping me the moment it's live and I'll pull
your numbers."

If, when you probe with `get_linkedin_metrics`, the connector isn't authorized in this session, tell the user
plainly that the ZenABM connector needs to be authorized (via their connector settings / an interactive session)
and that the audit can't run until then. Do not ask for tokens, codes, or callback URLs.

## 4. (Recommended) Connect HubSpot for deal influence
"Want the part of the audit that shows which ad formats actually influence your pipeline? Connect your CRM here:
**https://app.zenabm.com/data/crm-sync**. It's optional — I can run everything else without it — but it's where
the 'which formats drive deals' section comes from."

## Keeping it human
While each sync runs, keep the user company with short notes ("Once LinkedIn finishes syncing I'll pull your last
30 days..."). Never leave them staring at silence, and never promise numbers before the probe succeeds.
