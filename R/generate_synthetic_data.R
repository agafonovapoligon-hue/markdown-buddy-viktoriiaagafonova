# =============================================================================
# generate_synthetic_data.R
# -----------------------------------------------------------------------------
# AI Assistance Declaration: I used Claude (Anthropic, Claude Opus 5.5, Claude
# desktop app, 2026-11-18) for drafting code comments and file layout.
# Prompts used: see AI_Appendix.md. I verified outputs using RStudio (running
# the script and inspecting the CSV) and a manual line-by-line review. All
# final calculations are done by myself. I am responsible for the accuracy and
# originality of this work.
# -----------------------------------------------------------------------------
# Purpose : Create a reproducible, fully SYNTHETIC retail sales dataset.
#           No real or personal data is used.
# Output  : data/synthetic_sales.csv (600 rows, 6 columns)
# Usage   : source("R/generate_synthetic_data.R")   # run from project root
# =============================================================================

set.seed(400)  # fixed seed -> identical data on every run

n_orders <- 600
regions  <- c("North", "South", "East", "West")
products <- c("Laptop", "Monitor", "Keyboard", "Headset")

# Base list price per product (synthetic values)
list_price <- c(Laptop = 1200, Monitor = 300, Keyboard = 80, Headset = 150)

order_dates <- seq(as.Date("2025-01-01"), as.Date("2025-12-31"), by = "day")
product     <- sample(products, n_orders, replace = TRUE,
                      prob = c(0.20, 0.30, 0.25, 0.25))

sales <- data.frame(
  order_id   = sprintf("ORD-%04d", seq_len(n_orders)),
  order_date = sample(order_dates, n_orders, replace = TRUE),
  region     = sample(regions, n_orders, replace = TRUE),
  product    = product,
  units      = sample(1:10, n_orders, replace = TRUE),
  # +/- 10% price noise around the list price
  unit_price = round(unname(list_price[product]) * runif(n_orders, 0.9, 1.1), 2),
  stringsAsFactors = FALSE
)

# Inject a few missing values (3%) so the cleaning step has something to do
sales$units[sample(n_orders, size = 18)] <- NA

dir.create("data", showWarnings = FALSE)
write.csv(sales, "data/synthetic_sales.csv", row.names = FALSE)

message("Synthetic dataset written to data/synthetic_sales.csv")
