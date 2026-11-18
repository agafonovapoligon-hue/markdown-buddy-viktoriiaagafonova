# =============================================================================
# sales_summary.R
# -----------------------------------------------------------------------------
# AI Assistance Declaration: I used Claude (Anthropic, Claude Opus 5.5, Claude
# desktop app, 2026-11-18) for drafting code comments and section structure.
# Prompts used: see AI_Appendix.md. I verified outputs using RStudio (running
# the script, checking the output files) and a manual line-by-line review. All
# final calculations are done by myself. I am responsible for the accuracy and
# originality of this work.
# -----------------------------------------------------------------------------
# Purpose : Clean the synthetic sales data and summarise revenue by region
#           and by month.
# Input   : data/synthetic_sales.csv  (created by R/generate_synthetic_data.R)
# Outputs : output/region_summary.csv
#           output/monthly_revenue.csv
#           output/monthly_revenue.png
# Usage   : source("R/sales_summary.R")   # run from project root
# Requires: R >= 4.1 (native pipe), readr, dplyr, ggplot2 (>= 3.4)
# =============================================================================

suppressPackageStartupMessages({
  library(readr)
  library(dplyr)
  library(ggplot2)
})

input_path <- "data/synthetic_sales.csv"
output_dir <- "output"

# ---- 1. Load ----------------------------------------------------------------
if (!file.exists(input_path)) {
  source("R/generate_synthetic_data.R")
}
sales_raw <- read_csv(input_path, show_col_types = FALSE)

# ---- 2. Clean & derive ------------------------------------------------------
# Drop rows with missing units, then derive revenue and a year-month key.
sales <- sales_raw |>
  filter(!is.na(units)) |>
  mutate(
    revenue = units * unit_price,
    month   = format(order_date, "%Y-%m")
  )

# ---- 3. Summarise by region -------------------------------------------------
region_summary <- sales |>
  group_by(region) |>
  summarise(
    orders          = n(),
    total_units     = sum(units),
    total_revenue   = sum(revenue),
    avg_order_value = mean(revenue),
    .groups = "drop"
  ) |>
  arrange(desc(total_revenue))

# ---- 4. Summarise by month --------------------------------------------------
monthly_revenue <- sales |>
  group_by(month) |>
  summarise(total_revenue = sum(revenue), .groups = "drop") |>
  arrange(month)

# ---- 5. Visualise -----------------------------------------------------------
revenue_plot <- ggplot(monthly_revenue,
                       aes(x = month, y = total_revenue, group = 1)) +
  geom_line(colour = "#2C7FB8", linewidth = 1) +
  geom_point(colour = "#2C7FB8", size = 2) +
  scale_y_continuous(labels = scales::label_dollar()) +
  labs(
    title = "Monthly revenue (synthetic data, 2025)",
    x     = "Month",
    y     = "Revenue"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# ---- 6. Save outputs --------------------------------------------------------
dir.create(output_dir, showWarnings = FALSE)
write_csv(region_summary,  file.path(output_dir, "region_summary.csv"))
write_csv(monthly_revenue, file.path(output_dir, "monthly_revenue.csv"))
ggsave(file.path(output_dir, "monthly_revenue.png"), revenue_plot,
       width = 8, height = 4.5, dpi = 150)

message("Done. Outputs saved to the '", output_dir, "' folder.")
