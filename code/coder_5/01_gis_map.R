here::i_am("code/coder_5/01_gis_map.R")
direct_data_path<-here::here("clean_data/wastewater_clean.csv")
data<-read.csv(direct_data_path, header=T)

#Load required libraries
pacman::p_load(dplyr, usmap, ggplot2, gridExtra)

#Filter data to only 2023
data_2023 <- data %>%
  filter(year == 2023)

#Find the average percentile for the whole year
state_means <- aggregate(mean_percentile ~ state, data = data_2023, FUN = mean)

#Plot US map with states average mean_percentile for 2023
us_plot <- plot_usmap(data = state_means, values = "mean_percentile", lines = "white") +
  scale_fill_continuous(name = NULL,  # Remove legend title
                        label = scales::percent_format(scale = 1)) +
  theme(legend.title = element_text(margin = margin(b = 10)),  # Adjust legend title position
        plot.title = element_text(hjust = 0.5)) +  # Center the plot title
  ggtitle("2023 Prevalence of COVID-19 Virus in Wastewater by State")  # Add plot title

#save plot
ggsave(
  plot=us_plot,
  file=here::here("output", "us_plot.png"),
  device="png"
)