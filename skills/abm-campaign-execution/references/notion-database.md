# Optional: Notion campaign-management database

Offer this after the briefs are delivered. Ask two things: "Do you use Notion?" and "Would you like a Notion database to manage these campaigns more easily?"

## Setup (user does this)

1. Ask the user to **copy this template into their Notion workspace** first:
   https://app.notion.com/p/Sample-ABM-Campaign-Management-Database-1d4326f2804180589b91ffe77ea0c6f3
   (Open the link → Duplicate → pick their workspace.)
2. Ask them to **connect the Notion MCP** (Notion connector) if it isn't already connected, and to make sure the duplicated page is shared with the integration.
3. Ask them to **paste the link of the duplicated database** in their workspace.

## Filling the database (you do this)

1. Fetch the duplicated database with the Notion MCP (`notion-fetch` on their URL) and read its **actual schema** - property names, types, and select options. The template may have been edited; never assume the sample's schema. Map to whatever exists rather than inventing properties.
2. Create **one page per ad**. Set the properties that exist in their schema, typically:
   - Name/title → the ad name from the brief header
   - ABM Campaign / LinkedIn Campaign / Ad set → from the outline hierarchy
   - Format → Image / Video / Document / Carousel / Text / TLA
   - Persona / audience → from the ad set
   - Daily budget → from the outline
   - Status → the earliest option in their workflow (e.g. "Draft" / "Brief ready")
   - Owner / Posted by → for TLAs, the named author
3. Put the **full brief** in the page body (headings, copy blocks, design brief, images-needed list). For image ads, mention the mockup filenames (`.html` / `.png`) so the team can find them in the delivered folder.
4. If a property's select option doesn't exist (e.g. no "TLA" format option), create the option if the API allows it, otherwise pick the closest and tell the user what to rename.
5. When done, link the user to the filled database and list anything that needs a manual touch.

If the Notion MCP is not connected and the session can't run its OAuth flow, tell the user to connect Notion via their connector settings and come back - don't ask for tokens.
