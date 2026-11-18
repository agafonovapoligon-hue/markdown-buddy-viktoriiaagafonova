# Reflection — Markdown Buddy (BDA400, Assignment 1)

> **AI Assistance Declaration:** I used Claude (Anthropic, Claude Opus 5.5, Claude desktop app, 2026-11-18) for drafting and structuring the README, R Markdown file and this reflection. Prompts used: see [`AI_Appendix.md`](AI_Appendix.md). I verified outputs using GitHub's Markdown preview, RStudio *Knit to HTML*, and a manual review against the assignment rubric. All final calculations are done by myself. I am responsible for the accuracy and originality of this work.

**Author:** Viktoriia Agafonova · **Course:** BDA400 — Data Science Tools and Techniques

---

## 1. How did the AI tool support your documentation process, and where did it fall short?

**Where it helped**

- **Speed and structure.** The seed prompt produced a complete README skeleton
  (Overview, Installation, Usage, Example Code, License) in seconds. Starting
  from a structured outline is much faster than starting from a blank page.
- **Markdown conventions.** It reminded me of details I tend to forget: language
  tags on fenced code blocks, a table of contents with anchor links, badges, and
  tables for data dictionaries.
- **R Markdown best practices.** It suggested a `setup` chunk with global
  `knitr` options, named chunks, `toc_float`, and `eval = FALSE` for code that
  should be shown but not run (e.g., saving files or installing packages).

**Where it fell short**

- **Generic content.** The first README draft described a "typical" R project,
  not mine. It invented sections I did not need and missed the run order of my
  scripts. I had to supply concrete facts (file names, columns, outputs).
- **Version-sensitive code.** Suggested code used the native pipe `|>` and
  `ggplot2`'s `linewidth` argument without stating that they need R ≥ 4.1 and
  ggplot2 ≥ 3.4. I added both requirements after checking the documentation.
- **It cannot see the rendered result.** The AI can check syntax in text, but
  only the GitHub preview and knitting in RStudio prove that tables, anchors,
  and code chunks really render.

## 2. What did you verify or change after reviewing the AI's output, and why?

| What I checked | How | Change made |
|----------------|-----|-------------|
| README structure | Compared with the tidyverse **dplyr** README | Re-ordered sections to Overview → Installation → Usage, added Project Structure tree |
| Markdown syntax | GitHub preview of every heading, table, list and link | Added language tags to all code fences; fixed anchor links in the ToC |
| R code correctness | Read every line and ran the scripts in RStudio | In `summarise()`, renamed `revenue = sum(revenue)` to `total_revenue` so the next line, `mean(revenue)`, still uses the per-order values instead of the new total |
| Reproducibility of the `.Rmd` | Knitted on a clean session with no `data/` folder | Added a guard that sources the generator if the CSV is missing |
| Safe knitting | Reviewed chunks with side effects | Set `eval = FALSE` on the save and install chunks so knitting never overwrites files |
| Numbers in the text | Compared inline values with the console output | Replaced typed numbers with inline R (`` `r nrow(sales)` ``) so they are always computed by the code |

The most important catch was the `summarise()` naming issue: the code would
have run without an error but produced a wrong **average order value**. This
showed me that "it runs" is not the same as "it is correct", and that AI
suggestions need the same review as code from a colleague.

## 3. What ethical considerations apply when using AI for documentation, and how did you address them?

- **Transparency.** I disclosed the tool, model, date and prompts in every file
  (AI Assistance Declaration) and kept a full prompt log in `AI_Appendix.md`.
  Readers can see exactly which parts were AI-assisted.
- **Accountability.** I am responsible for every line in the repository. I did
  not accept any output without checking it, and all results come from running
  my R code — the AI did not compute any numbers.
- **Privacy.** Only **synthetic** data were used. No real customer or personal
  information was shared with the AI tool.
- **Accuracy and over-trust.** AI text sounds confident even when it is wrong
  (for example, the missing version requirements). I treated it as a design
  assistant and verified claims against official documentation.
- **Originality and learning.** Using AI to draft documentation is acceptable
  only if I understand and can explain every section. Going forward I will use
  AI for structure and formatting ideas, but write the project-specific
  content myself and always keep a disclosure.

---

*Overall, AI made documentation faster and more consistent, but the quality of
the final files depended on my verification: previewing, knitting, comparing
with real repositories, and correcting what the AI got wrong.*
