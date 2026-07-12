---
name: abm-campaign-execution
description: Turn a finished LinkedIn ABM strategy into launch-ready campaign assets - a concise ABM Campaign Outline, per-ad copy & design briefs, on-brand image-ad mockups rendered as HTML + PNG files, and an optional campaign-management database (Notion or Google Sheets). Use this skill whenever the user wants to execute, operationalize, or "build the ads for" an ABM strategy; asks for ad briefs, a campaign outline, ad mockups, LinkedIn ad creatives, TLA (Thought Leader Ad) copy, or campaign briefs; or says things like "turn my strategy into campaigns", "create the ads from the plan", "make the briefs", or "set up my campaign database in Notion or Google Sheets". It is the follow-up to the abm-strategy-planning skill - if a strategy was just produced in this conversation, this is the skill that executes it.
---

# ABM Campaign Execution

Take the ABM strategy produced by `/abm-strategy-planning:abm-strategy-planning` (or an equivalent uploaded strategy) and turn it into everything needed to launch: an outline, ad briefs, rendered image-ad mockups, and optionally a Notion or Google Sheets database to manage it all.

The strategy decides *what* to run. This skill decides *exactly what each ad says and looks like*. Do not re-litigate the strategy: take its campaigns, ad sets, formats, budgets, audiences and value props as given.

## Connectors for this skill

Unlike the audit and report skills, **this skill doesn't read your live LinkedIn Ads data** — it builds from the strategy you already have, so the **ZenABM connector is optional here.** Two things worth knowing:

- **ZenABM connector (optional):** only helpful if you want to ground the ads in real ZenABM data (e.g. real engaged accounts to name). New to ZenABM? Start a free trial at https://app.zenabm.com/signup and follow the connector setup guide at https://zenabm.com/mcp/docs.
- **Notion or Google Drive connector (optional):** used only for the optional campaign-management database in Step 6 — **Notion** for a Notion database, or **Google Drive** to drop the filled Google Sheet into your Drive. You'll approve whichever you pick when you get there (the Google Sheets option also works as a plain `.xlsx` download with no connector at all).

## Step 0 - Locate the strategy

Work through these in order:

1. **Conversation context.** If an ABM strategy (from `abm-strategy-planning`, an ABM strategy deck, or equivalent) exists earlier in this conversation, use it.
2. **Ask for it.** If not, ask the user to either upload their strategy document or run `/abm-strategy-planning:abm-strategy-planning` first.
3. **No skill installed?** If they don't have the strategy skill, point them to download it from https://github.com/ZENABM/linkedin-abm-skills and upload/install it, then come back.

Do not invent a strategy from scratch. Without one, this skill has nothing to execute.

## Step 1 - ABM Campaign Outline (deliver this FIRST, as an artifact)

Distill the strategy into a concise, actionable outline and hand it to the user **before** anything else - it needs only the strategy, not the interview, and it lets them correct the map before you build the territory. The outline is also the **index to every deliverable**: each ad gets its **own brief file** (Step 3) and, for image ads, its **own mockup files** (Step 4), and the outline links to each one directly. Produce three sibling files at the root of the output folder and present them immediately:

- `00-ABM-Campaign-Outline.md` - the plain-markdown source
- `00-ABM-Campaign-Outline.html` - a styled, self-contained artifact version: brand-neutral clean layout, collapsible campaign sections, a "Download PDF" button (`window.print()` with print CSS), and the per-campaign **Assets** tables described below with **relative links to each individual ad's brief and creative files**. If a live-artifact tool is available (e.g. Cowork's `create_artifact`), publish the same HTML there too.
- `00-ABM-Campaign-Outline.pdf` - pre-rendered via `scripts/render_ads.sh --pdf 00-ABM-Campaign-Outline.html 00-ABM-Campaign-Outline.pdf`

**File-path convention (fixed - Steps 3 and 4 must produce exactly these paths so the outline's links resolve).** Give each ABM campaign a kebab-case folder slug and number the ads within it (01, 02, ...) in outline order:

- Brief (one per ad, every format): `./[abm-campaign-slug]/briefs/[NN]-[format]-[ad-slug].md` (+ `.docx` if docx tooling is available). `[format]` is lowercase: `image`, `tla`, `text`, `video`, `document`, `carousel`.
- Mockup (image ads only): `./[abm-campaign-slug]/mockups/[NN]-[ad-slug].html` and `./[abm-campaign-slug]/mockups/[NN]-[ad-slug].png` - same `[NN]` and `[ad-slug]` as the ad's brief.

Links are **relative within the delivered folder**, so they work when the user opens the folder locally. The target files don't exist yet at Step 1 - that's fine; you're publishing the map first, then Steps 3-4 fill in exactly these paths.

**ZenABM branding (required on the outline artifact + PDF):** put the ZenABM logo (`assets/logo_dark.png`, embedded as a base64 `data:image/png;base64,...` URI at ~28px height so the artifact stays self-contained) in a top bar above the client title, and a footer bar that repeats on every printed page (`position: fixed; bottom: 0` + `body{padding-bottom}` so content never overlaps): the text "Make most out of your ABM campaigns - track performance on company level with ZenABM" followed by a pill button "Start FREE" linking to https://app.zenabm.com/signup.

Use exactly this hierarchy (an ABM Campaign is the highest-order unit targeting a distinct audience). Each ABM campaign ends with an **Assets** table that links to every file produced for it:

```
# ABM Campaign Outline

## ABM Campaign 1 - [Title] - [Persona]

### LinkedIn Campaign 1

#### Ad set 1 - [FORMAT] - [daily budget]
- Ad 1 - [FORMAT] - [what it's about]
- Ad 2 - [FORMAT] - [what it's about]

#### Ad set 2 - [FORMAT] - [daily budget]
- Ad 1 - ...

#### Assets for ABM Campaign 1
| # | Ad | Format | Brief | Creative |
|---|----|--------|-------|----------|
| 1 | [ad name] | Image | [brief](./campaign-1-slug/briefs/01-image-[slug].md) | [PNG](./campaign-1-slug/mockups/01-[slug].png) · [HTML](./campaign-1-slug/mockups/01-[slug].html) |
| 2 | [ad name] | TLA | [brief](./campaign-1-slug/briefs/02-tla-[slug].md) | post copy is in the brief |
| 3 | [ad name] | Text | [brief](./campaign-1-slug/briefs/03-text-[slug].md) | copy is in the brief |

## ABM Campaign 2 - [Title] - [Persona]
...
```

Every row's **Brief** link points at that ad's own file; the **Creative** cell links the mockup **PNG + HTML** for image ads, and for TLAs/text/video/document/carousel it just notes the copy lives in the brief (there's no separate image file). If docx briefs are produced, link the `.docx` instead of (or alongside) the `.md`. This table is the "very clear, concise list of assets per ABM campaign with working links" - it must be present for every ABM campaign.

Derive daily budgets from the strategy's monthly allocations (monthly ÷ 30, rounded sensibly). One line per ad - format plus a 5-15 word "what about". Keep the whole outline scannable in under a minute; it's the map, the briefs are the territory.

**Only include the ad formats the strategy actually calls for.** If the strategy has no video ads, there are no video briefs. Never pad the plan with extra formats to be thorough.

## Step 2 - Interview the user

Before writing briefs or mockups, gather what the strategy can't tell you. Use the AskUserQuestion tool where it fits; batch questions, don't drip them.

**A. Design system** (for image-ad mockups):
- Primary / accent / dark-background colors (hex), text-on-dark, muted text
- Font (and heading/body weights)
- Logo (SVG code pasted, a file in the images folder, or "company name in font X")
- Tone (e.g. "direct, numbers over adjectives, short punchy lines")
- If they have a brand config from the LinkedIn Ad Designer format, accept it verbatim.

**B. Images folder.** Based on the ads you plan, recommend the specific images each mockup needs (product screenshots, founder/poster headshots, customer logos, report covers, G2 badges). Ask the user to put them all in **one local folder** and share/connect it. Every brief must list which image files it needs by name, and mockups must use these real files - not placeholders - wherever the user has provided them.

**C. TLA inputs** (only if the strategy includes Thought Leader Ads):
- **Who posts each TLA** - name and position in the company. Ask explicitly; a TLA without a real author is dead on arrival.
- For each TLA use case: **numbers, personal experience, and learnings** the author can genuinely share (real metrics, a mistake they made, a client story, before/after figures). Specificity is what makes TLAs perform - never fabricate these.
- The demo / trial / landing URL the CTA should point to.

**D. Personalization macros.** Confirm whether they want personalized intro-text variants (`%FIRSTNAME%`, `%COMPANYNAME%`, `%INDUSTRY%`, `%JOBTITLE%`).

## Step 3 - Write the ad briefs (ONE FILE PER AD)

Give **every ad its own brief file** - regardless of format - saved under its ABM campaign's `briefs/` folder using the fixed path convention from Step 1: `./[abm-campaign-slug]/briefs/[NN]-[format]-[ad-slug].md`. Do **not** compile everything into one combined document; separate files are easier to find, share and link, and they make each of the outline's Assets links resolve to a specific ad. If docx tooling is available (e.g. the docx skill), also export each brief as a sibling `.docx` (`[NN]-[format]-[ad-slug].docx`) and link that from the outline.

Each brief file:
- **Starts with a clear H1 title** = the ad name (e.g. `# ABM Campaign 1 · Ad set 1 · Ad 1 (Image) - [slug]`), so the file makes sense opened on its own.
- Then the standard header block, followed by the body from the matching template in `references/brief-templates.md` (image, video, document, carousel, text). For TLAs, follow `references/tla-writing.md` instead - it has its own structure, rules and benchmark-backed patterns.
- **Must match the exact filename the outline's Assets table links to** (same `[NN]`, `[format]`, `[ad-slug]`). If you rename or renumber an ad, update the outline row too - briefs and outline links never drift apart.

Non-negotiables for all copy:

- Apply `references/anti-slop.md` to every word. Write clean from the start; don't draft slop and fix it later.
- Use the ad set's **target persona** from the strategy - the reader is a specific person, not "decision makers".
- Reuse the strategy's value props and messages as the starting point for each ad's angle.
- Each brief states which **image files** it needs (exact filenames from the user's folder, or a clearly-marked request for a file that doesn't exist yet) AND where each one sits in the design ("headshot in a circular avatar bottom-left", "screenshot filling the bottom half"). The mockup must match this exactly - see Step 4.
- Respect format limits (text ads: 25-char headline / 75-char description; video intro text: 600 chars; headline: 200 chars).

## Step 4 - Image-ad mockups (HTML + PNG)

For every **image ad**, build an on-brand mockup following `references/ad-design-patterns.md`:

- One self-contained HTML file per ad: square 1:1, 540px, inline styles only, brand colors/font from the interview, rich style (gradient background, one glass element, subtle shapes, shadows).
- Pick the design pattern that fits the ad's job (stat, contrarian, product screenshot, before/after, testimonial...) - the reference lists 23 patterns with when-to-use guidance.
- **Brief ↔ mockup image correspondence is a hard rule.** The mockup uses exactly the image files its brief lists, in the placement the design brief describes - nothing extra, nothing swapped. If the brief says "riege.jpg in a circular avatar next to the quote", that is what the HTML contains. Update the brief if the design changes; never let them drift apart.
- **Photo placement rules** (photos fail most mockups): pre-crop each photo to the container's exact aspect ratio with Python/PIL before embedding (crop toward faces/subject, never let a head be clipped); in HTML use a fixed-size container with `object-fit: cover`; prefer contained slots (avatar circle, right column, framed card) over full-bleed backgrounds; if a photo needs an overlay to keep text readable, cap it at ~55% opacity and re-check the subject is still clearly visible in the PNG.
- Reference the user's images with relative paths (`./images/...`) and copy the images next to the HTML so both browser preview and PNG render work.
- Render each HTML to a 1080x1080 PNG with `scripts/render_ads.sh` (it bootstraps headless Chromium without root - see the script header). Ship **both** the .html (editable) and .png (uploadable) per ad.
- After rendering, view each PNG and fix visual problems (overflow, contrast, broken images) before delivering. An unreviewed mockup is a draft, not a deliverable.

## Step 5 - Output folder

Deliver everything in one folder:

```
[Client]-ABM-Campaign/
├── 00-ABM-Campaign-Outline.md / .html / .pdf     (delivered first; links to every asset below)
├── [abm-campaign-1-slug]/
│   ├── briefs/           (one brief file per ad, any format: NN-format-slug.md [+ .docx])
│   └── mockups/          (image ads only: NN-slug.html + NN-slug.png per ad)
│       └── images/       (copies of the user images used)
└── [abm-campaign-2-slug]/
    ├── briefs/
    └── mockups/
        └── images/
```

Present the folder's key files to the user when done (the outline artifact + a couple of sample brief files + a sample mockup), and confirm the outline's Assets links open the right files.

## Step 6 - Campaign-management database (ALWAYS OFFER THIS)

After the briefs and mockups are delivered, **always ask** whether they'd like a campaign-management database - don't skip this step. Explain the payoff in a line: **a database makes every future campaign far easier to manage** - one row (or page) per ad, filterable by campaign, persona, format, stage and status, with links to every brief and graphic in one place.

Then ask which they'd prefer:

- **Notion** - follow `references/notion-database.md` (they duplicate the ZenABM template, connect the Notion MCP, share the link, and you fill it - one page per ad with the full brief and correct properties).
- **Google Sheets** - follow `references/google-sheets-database.md`. Reproduce the ZenABM campaign-database template (bundled at `assets/campaign-database-template.xlsx`) and **fill it with the ads you just built** - one row per ad, with the auto-generated Campaign / Ad set / Ad names and links to each brief file and mockup. Deliver it as an `.xlsx` they can open or upload to Google Sheets; if the **Google Drive** connector is available, also offer to create it directly in their Drive as a live Sheet (ask first - that writes to their account).

Pick one, build it, and hand it over. If they genuinely don't want a database, skip it - but make the offer.

## Quality bar

Before delivering, check: every ad in the outline has its **own brief file** at the exact path the Assets table links to, and **every one of those links resolves** (no dead links, no `01-Ad-Briefs`-style combined doc); every image ad has an HTML + PNG pair you have actually looked at, linked from its Assets row; no brief references an image that isn't either in the folder or explicitly requested; TLA copy passes the checklist in `references/tla-writing.md`; nothing in any brief exists for a format the strategy didn't ask for.
