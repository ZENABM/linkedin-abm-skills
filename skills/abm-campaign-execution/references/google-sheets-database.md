# Optional: Google Sheets campaign-management database

Offer this alongside the Notion option (see Step 6). Pitch it in a line: **a database makes future
campaigns far easier to manage** - one row per ad, filterable by campaign, persona, format, stage and status,
with a link to every brief and graphic in one place. Use this path when the user prefers Google Sheets (or a
spreadsheet they can open in Excel).

## The template

A ready-made template is bundled at **`assets/campaign-database-template.xlsx`**. Reproduce it and fill it with
the ads you just built - do **not** hand over the blank template alone. It has one worksheet, `Campaigns`, plus
a `How to use` legend sheet.

**One row = one ad.** Columns, in three merged groups:

| Group | Column | What goes in it |
|---|---|---|
| **Campaign Group** | ABM Campaign Name | the ABM campaign title from the outline |
| | Channel | ad channel - `Li` for LinkedIn |
| | Intent | the intent / theme / job-to-be-done |
| | Persona | the ad set's target persona |
| **Campaign** | Stage | funnel stage: `Awareness` / `Consideration` / `Selection` (use the strategy's stages) |
| | Inventory Type | ad format: `Image` / `Video` / `TLA` / `Text` / `Document` / `Carousel` |
| **Ad** | Willingness to buy | `Low` / `High` |
| | CTA | `Trial` / `Demo` (or the ad's actual CTA) |
| | Size | `Short` / `Long` (intro-text length) |
| **Generated names & assets** | Campaign Name | **auto** - `=TRIM(ABM Campaign & " " & Channel & " " & Intent & " " & Persona)` |
| | Ad Set Name | **auto** - `=TRIM(Campaign Name & " " & Stage & " " & Inventory Type)` |
| | Ad Name | **auto** - `=TRIM(Ad Set Name & " " & Willingness & " " & CTA & " " & Size)` |
| | Person Responsible | ad owner; for a **TLA**, the named author from the interview |
| | Brief Template | link to that ad's brief file (`./[campaign]/briefs/NN-format-slug.md`) |
| | Graphic Link | link to the image-ad mockup PNG (`./[campaign]/mockups/NN-slug.png`); blank for TLA/Text/etc. |

The three **Generated names** columns are formulas - don't type them by hand; they rebuild if an attribute
changes. Keep font Arial and the group-header colours as in the template.

## Filling it (you do this)

1. **Copy the bundled template** into the campaign's output folder as `[Client]-ABM-Campaign-Database.xlsx`
   (openpyxl; keep the headers, merged groups, legend sheet and the three name formulas intact).
2. **Add one row per ad** you produced - every format, matching the outline's Assets tables. Fill the coloured
   attribute columns; let the three name columns compute.
3. **Link each ad to its files:** set the **Brief Template** cell's hyperlink to the ad's brief path and the
   **Graphic Link** cell's hyperlink to its mockup PNG (image ads only - for TLA/Text/Document/Carousel put a
   short "- copy in brief" note instead). Use the same relative paths the outline uses, so the links resolve when
   the folder is opened locally.
4. **Recalculate** the workbook (the xlsx skill's `scripts/recalc.py`) so the generated names are populated, and
   confirm `total_errors: 0`.
5. **Deliver the `.xlsx`** and tell the user they can open it in Excel or upload it to Google Sheets
   (File -> Import), and that the coloured columns are the ones they edit going forward.

## Optional: create it as a live Google Sheet

If the **Google Drive** connector is available and the user wants it in their Drive, offer to create it there -
**ask first**, since that writes to their account. Then upload the `.xlsx` via the Drive connector's
`create_file` (convert to a Google Sheet), and share the link. If the connector isn't available, just deliver the
`.xlsx` and point them to *File -> Import* in Google Sheets.

Never paste credentials or tokens in chat. If the Drive connector needs authorizing, tell the user to approve it
in their connector settings and come back.
