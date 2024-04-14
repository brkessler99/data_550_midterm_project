here::i_am("code/coder_2/01_make_desc_table.R")
absolute_path_to_data <- here::here("clean_data/wastewater_clean.csv")
data <- read.csv(absolute_path_to_data, header = TRUE)

pacman::p_load(kableExtra, dplyr,tidyr)

#mean percentile avg per year by region
mean_percentile_year_region <- data |>
  group_by(year, region) |>
  rename(Region = region) |>
  summarize(mean_percentile = mean(mean_percentile, na.rm = TRUE))

#mean percentile avg per year
mean_percentile_year_overall <- data |>
  group_by(year) |>
  summarize(mean_percentile = mean(mean_percentile, na.rm = TRUE)) |>
  mutate(Region = "Overall")

#combined table
combined_data <- bind_rows(mean_percentile_year_region, mean_percentile_year_overall)

desc_table <- combined_data |>
  pivot_wider(names_from = year, values_from = mean_percentile, names_prefix = "Year_", values_fill = NA) |>
  rename_with(~sub("Year_", "", .x), starts_with("Year_")) |>
  arrange(Region != "Overall") |>
  kable(digits = 1,caption = "Table 1: SARS-CoV-2 virus level mean percentile by US region from 2020-2023") |>
  kable_styling(bootstrap_options = "striped", full_width = F, position = "left")

saveRDS(
  desc_table,
  file = here::here("output/desc_table.Rds")
)