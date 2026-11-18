# Appendix — AI Prompt Log and Verification Record

> **AI Assistance Declaration:** I used Claude (Anthropic, Claude Opus 5.5, Claude desktop app, 2026-11-18) for README outlining, Markdown/R Markdown drafting and formatting, and syntax review. Prompts used: listed below. I verified outputs using GitHub's Markdown preview, RStudio *Knit to HTML*, comparison with the tidyverse dplyr README, and a manual line-by-line review. All final calculations are done by myself. I am responsible for the accuracy and originality of this work.

| Field | Value |
|-------|-------|
| Tool | Claude (Anthropic) |
| Model / version | Claude Opus 5.5 |
| Interface | Claude desktop app |
| Date | 2026-11-18 |
| Data shared with AI | Assignment instructions and a description of my **synthetic** dataset only — no real or personal data |

**Session note:** I first gave Claude the assignment instruction PDF and asked
it to help me prepare all deliverables. The prompts below were then worked
through in the same session. Responses are summarised (key points only).

---

## Step 1 — Understand Markdown structure

### Prompt 1.1 (Seed)

> Explain what sections a good GitHub README for an R data analysis project should include.

**Key response:** Title and one-line description; badges; Overview/purpose;
Project structure; Data description; Installation (R version + packages);
Usage / how to run; Example code; Outputs/results; Documentation links;
Contributing; License; Contact/acknowledgements.

### Prompt 1.2 (Refinement)

> Revise the sections list so it's concise and uses Markdown headers and bullet formatting.

**Key response (final outline used for the README):**

```markdown
# Project Title
> One-line description + badges

## Table of Contents
## Overview
- Business questions answered
## Project Structure
- Folder tree with one comment per file
## Dataset
- Source (synthetic), data dictionary table
## Installation
- R version, packages, clone command
## Usage
- Exact run order of scripts
## Example Code
- One short, representative code block
## Outputs
- Table of generated files
## Documentation
- Links to .Rmd, Reflection, Appendix
## License
## AI Assistance Disclosure
```

### Prompt 1.3 (Critique / Validation)

> Check the Markdown syntax for correctness and readability.

**Key response:** Use one `#` H1 only; do not skip header levels; leave a blank
line before lists and code fences; add a language tag to every code fence;
ToC anchors must be lowercase with spaces replaced by hyphens.

**Verification (Step 1):** Compared with the
[tidyverse/dplyr README](https://github.com/tidyverse/dplyr): it uses
Overview → Installation → Usage → Getting help. I kept that order and added
project-specific sections (Project Structure, Dataset, Outputs) that a data
analysis project needs but a package README does not.

---

## Step 2 — README.md draft

### Prompt 2.1 (Seed)

> Here's a summary of my R project: *An R project that generates a synthetic
> retail sales dataset (600 orders, 4 regions, 4 products, 2025) and
> summarises revenue by region and by month. Key scripts:
> `R/generate_synthetic_data.R`, `R/sales_summary.R`; documentation in
> `sales_summary.Rmd`. Dependencies: readr, dplyr, ggplot2, rmarkdown.*
> Generate a professional README.md file using Markdown.

**Key response:** Draft README with title, overview, project structure, usage
and outputs.

### Prompt 2.2 (Refinement)

> Add sections for Installation, Example Code, and License. Keep tone concise and professional.

**Key response:** Added Installation (clone + `install.packages()`), an
Example Code block with the `group_by()`/`summarise()` pipeline, and an MIT
License section.

### Prompt 2.3 (Critique / Validation)

> Review the Markdown for syntax errors and suggest 2 improvements for clarity.

**Key response:**

1. *Syntax:* one code fence lacked a language tag; nested list under a numbered
   step needed 3-space indentation to render inside the step.
2. *Improvement 1:* add a Table of Contents and a Project Structure tree.
3. *Improvement 2:* present the dataset as a data dictionary table instead of
   a paragraph.

**Changes I applied:** both improvements, both syntax fixes, plus the
R ≥ 4.1 requirement and the exact script run order.

---

## Step 3 — R Markdown documentation

### Prompt 3.1 (Seed)

> Here's my R script description: *`R/sales_summary.R` reads
> `data/synthetic_sales.csv`, drops rows with missing units, derives revenue
> and month, summarises by region and by month, draws a line chart, and saves
> two CSVs and a PNG to `output/`.* Suggest Markdown formatting and code block examples.

**Key response:** YAML header with `html_document`; a `setup` chunk; one
named chunk per script step; `knitr::kable()` for tables; inline R for counts.

### Prompt 3.2 (Refinement)

> Add syntax highlighting and improve section organization (e.g., # Purpose, ## Inputs, ## Outputs).

**Key response:** Added `highlight: tango`, `toc_float`, `number_sections`,
`code_folding: show`; organised as **Purpose → Inputs → Dependencies →
Workflow (Steps 1–5) → Outputs → How to Run → Assumptions and Limitations →
Session Information**.

### Prompt 3.3 (Critique / Validation)

> Is the Markdown consistent with RMarkdown best practices?

**Key response:** Mostly yes. Recommended: unique chunk labels without spaces;
`message = FALSE, warning = FALSE` in `setup`; `eval = FALSE` for chunks with
side effects (installing packages, writing files); end with `sessionInfo()` for
reproducibility; use inline R instead of typed numbers.

**Changes I applied:** all five recommendations; added a guard that runs the
data generator if the CSV is missing so the `.Rmd` knits on a fresh clone.

---

## Verification Log

| # | Check | Method | Result / action |
|---|-------|--------|-----------------|
| 1 | README renders correctly | GitHub file preview | Headers, tables, code blocks, badges and ToC links render |
| 2 | `.Rmd` knits without errors | RStudio → *Knit to HTML* | All chunks run; ToC, tables and Figure 1 render |
| 3 | Chunk code matches script | Side-by-side comparison with `R/sales_summary.R` | Identical logic |
| 4 | Summary logic is correct | Manual review of `summarise()` | Ensured `avg_order_value` uses per-order `revenue`, not the total |
| 5 | Results not computed by AI | All numbers produced by R at knit time (inline R) | No hard-coded figures |
| 6 | Privacy | Data review | Synthetic data only |
| 7 | Repository hygiene | `.gitignore` for generated files | Only source and documentation files committed |
