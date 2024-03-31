here::i_am("code/coder_3/02_bargraph.R")
absolute_path_to_data <- here::here("clean_data/wastewater_clean.csv")
data <- read.csv(absolute_path_to_data, header = TRUE)


pacman::p_load(ggplot2, janitor, tidyr, graphics)


barplot<- ggplot(data, aes(x = region, y= mean_percentile,fill = factor(year))) +
  geom_bar(stat = "identity", position = "dodge") + 
  labs(x = "US Regions", y = "Percentile", fill= "Year") +  
  scale_fill_manual(values= c("2020"= "#1f77b4", "2021"= "#ff7f0e", "2022"= "#2ca02c", "2023"= "#d62728", "2024"= "#bababa"))+
  theme_classic()+
  theme(axis.text.x = element_text(size=12, angle = 90, vjust = 0.5),
        legend.text = element_text(size=12),
        legend.key.size = unit(10,"pt"),
                                      )
ggsave(
  here::here("output/bargraph.png"),
  plot = barplot,
  device="png"
)



