# Change in total US and user-specified region(s) wastewater prevalence from 2020-2023
# By Jiawen Shi

pacman::p_load(ggplot2, dplyr, lubridate)

here::i_am("code/coder_2/01_line_graph.R")

data_dir <- here::here("midterm_project/clean_data/wastewater_clean.csv")
data <- read.csv(data_dir, header = TRUE)

data$Date <- make_date(data$year, data$month)

# Since we are using data from 2020 - 2023
data <- filter(data, year >= 2020 & year <= 2023)

# Aggregate to calculate the mean percentile for the US for each month
us_total <- data %>%
  group_by(Date) %>%
  summarize(mean_percentile = mean(mean_percentile, na.rm = TRUE)) %>%
  mutate(region = "Total US")

# Append the US total data to the original dataset
data <- bind_rows(data, us_total)

# Calculate average percentile for each region in each month
average_data <- data %>%
  group_by(region, Date) %>%
  summarize(mean_percentile = mean(mean_percentile, na.rm = TRUE), .groups = 'drop')

# Plotting
figure3 <- 
  ggplot(average_data, aes(x = Date, y = mean_percentile, color = region)) +
  geom_line() +
  labs(title = "Average Wastewater Prevalence by Region (2020-2023)",
       x = "Date",
       y = "Average Mean Percentile",
       color = "Region") +
  theme_minimal() +
  scale_x_date(date_breaks = "1 year", date_labels = "%Y")

# Save linegraph file
ggsave(
  here::here("output/figure_three.png"),
  plot = figure3,
  device = "png"
)
