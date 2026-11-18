# Reflection — Markdown Buddy (BDA400, Assignment 1)

> **AI Assistance Declaration:** I used Claude (Anthropic, Claude Opus 5.5, Claude desktop app, 2026-11-18) for drafting and structuring the README, R Markdown file and this reflection. Prompts used: see [`AI_Appendix.md`](AI_Appendix.md). I verified outputs using GitHub's Markdown preview, knitting the `.Rmd` in Posit Cloud, a file-by-file comparison of the GitHub copies with my local files, and a manual review against the assignment rubric. All final calculations are done by myself. I am responsible for the accuracy and originality of this work.

**Author:** Viktoriia Agafonova · **Course:** BDA400 — Data Science Tools and Techniques

---

## 1. How did the AI tool support your documentation process, and where did it fall short?

**Where it helped**

- **Speed and structure.** Working from the assignment instructions, Claude
  produced a complete first version of every deliverable — README outline,
  README, R scripts, R Markdown file and prompt log — in one session. Starting
  from a structured draft is much faster than starting from a blank page.
- **Learning by example.** The drafts showed me what professional
  documentation looks like: a table of contents with anchor links, a project
  structure tree, a data dictionary table, language tags on every code block,
  and a clear "how to run" order.
- **R Markdown best practices.** It used a `setup` chunk with global `knitr`
  options, named chunks, a floating table of contents, inline R for numbers,
  and `eval = FALSE` for code that should be shown but not executed.
- **Tool workflow.** R is not installed on my computer, so the AI suggested
  creating a Posit Cloud project directly from my GitHub repository. This let me
  knit the `.Rmd` without any local setup.

**Where it fell short**

- **The text is not automatically "mine".** AI drafts are fluent and generic.
  A reader cannot tell what I understood unless I review the content and can
  explain every section myself.
- **It cannot prove that things work.** The AI can write correct-looking
  Markdown and R code, but only the GitHub preview and an actual knit show that
  tables, links and code chunks really render and run.
- **It can overreach.** The course rules ask for AI as a design assistant, not
  an answer generator. Because the AI could produce everything at once, I had to
  make a deliberate effort to stay in control: reviewing, running and checking
  the work instead of accepting it as finished.

## 2. What did you verify or change after reviewing the AI's output, and why?

| What I checked | How | Result / change |
|----------------|-----|-----------------|
| Files on GitHub match my local files | Compared a SHA-256 checksum of every file in the repository with the local copy | All 8 files identical |
| README renders correctly | GitHub preview; checked headings, tables, code blocks, badges and every Table of Contents link | 11 sections, 3 tables, 5 code blocks and 3 badges render; all ToC links resolve |
| README is usable as written | Replaced the `<your-username>` placeholder in the clone command | Clone URL now points to my repository |
| `.Rmd` knits on a fresh copy | New Posit Cloud project from the GitHub repo (R 4.6.2), installed packages, ran `rmarkdown::render()` | `sales_summary.html` created, 0 chunk errors, 11 tables, Figure 1 embedded |
| Scripts produce the documented outputs | Ran `R/generate_synthetic_data.R` and `R/sales_summary.R` | `region_summary.csv`, `monthly_revenue.csv`, `monthly_revenue.png` created |
| Cleaning step behaves as documented | Compared row counts before and after cleaning | 18 rows removed (3 % of 600), as designed |
| Summary logic | Read the `summarise()` call line by line | `avg_order_value` is the mean of per-order `revenue`, not of the region total, because the total is stored under a different name (`total_revenue`) |
| Structure vs. a real project | Compared with the tidyverse **dplyr** README | Same core order (Overview → Installation → Usage); extra sections for data and outputs suit an analysis project |

The `summarise()` check taught me the most. If the total had been named
`revenue`, the next line `mean(revenue)` would have silently averaged the
total instead of the orders. The code would still run, but the average would
be wrong. "It runs" is not the same as "it is correct", so AI-written code
needs the same review as code from a colleague.

## 3. What ethical considerations apply when using AI for documentation, and how did you address them?

- **Transparency.** Every file starts with an AI Assistance Declaration naming
  the tool, model and date, and `AI_Appendix.md` records the prompts, the key
  responses and my original request to the AI. Readers can see how much of the
  work was AI-assisted.
- **Accountability.** I am responsible for everything in the repository. I did
  not submit anything I had not run or previewed, and every number in the
  documentation is computed by R at knit time — the AI did not calculate any
  results.
- **Privacy.** Only **synthetic** data were used. No real customer or personal
  information was shared with the AI.
- **Over-trust.** AI output sounds confident whether it is right or wrong. I
  treated it as a draft and checked it with independent tools (GitHub preview,
  Posit Cloud, checksums).
- **Learning and originality.** The biggest risk is letting the AI do the
  learning for me. Going forward I will write the project-specific content
  myself, use AI mainly for structure, formatting ideas and review, and always
  keep a disclosure.

---

*Overall, AI made the documentation faster and more professional, but the
value of the final submission comes from verification: previewing on GitHub,
knitting in Posit Cloud, comparing with real repositories, and being able to
explain every line.*
