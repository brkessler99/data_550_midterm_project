here::i_am("code/coder_1/01_clean_data.R")
pacman::p_load(tidyverse,rio,lubridate)
wastewater <- import(here::here("raw_data/wastewater_feb25.csv.zip")) %>% 
  janitor::clean_names() 

# import data -------------------------------------------------------------

wastewater_state <- wastewater %>% 
  select(wwtp_jurisdiction,county_names,county_fips,population_served,first_sample_date,percentile) %>% 
  mutate(month=month(wastewater$first_sample_date)) %>% 
  mutate(year=year(wastewater$first_sample_date))

# create a function to calculate state mean by month ----------------------

state_month_mean <- function(state_name,state_month,state_year) {
  state_month_mean_data <- wastewater_state %>% filter(wwtp_jurisdiction == state_name) %>% filter(month == state_month) %>% filter(year == state_year)
  state_month_mean_value <- mean(state_month_mean_data$percentile,na.rm=TRUE)
  return(state_month_mean_value)
}

    #NOTE: seq will give you positions

# for loop to calculate values and make df --------------------------------

all_states <- c(
  "Alabama", "Alaska", "Arizona", "Arkansas", "California",
  "Colorado", "Connecticut", "Delaware", "Florida", "Georgia",
  "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa",
  "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland",
  "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri",
  "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey",
  "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio",
  "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina",
  "South Dakota", "Tennessee", "Texas", "Utah", "Vermont",
  "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"
)
year_range <- 2020:2024
month_range <- seq(1:12)

state_month_percentile_mean <- data.frame(matrix(nrow=length(all_states)*length(year_range)*length(month_range),ncol=4))
colnames(state_month_percentile_mean) <- c("state","year","month","mean_percentile")
count_position <- 0

for (i in all_states) {
  message(i)
  for (j in year_range) {
    for (k in month_range) {
      count_position <- count_position+1
      state_month_percentile_mean$state[count_position] <- i
      state_month_percentile_mean$year[count_position] <- j
      state_month_percentile_mean$month[count_position] <- k
      state_month_percentile_mean$mean_percentile[count_position] <- state_month_mean(state_name=i, state_month=k, state_year=j)
    }
  }
}

# define US regions -------------------------------------------------------

northeast <- c("Connecticut", "Maine", "Massachusetts", "New Hampshire", "Rhode Island", "Vermont", "New Jersey", "New York", "Pennsylvania")
midwest <- c("Illinois", "Indiana", "Michigan", "Ohio", "Wisconsin", "Iowa", "Kansas", "Minnesota", "Missouri", "Nebraska", "North Dakota", "South Dakota")
south <- c("Delaware", "Florida", "Georgia", "Maryland", "North Carolina", "South Carolina", "Virginia", "West Virginia", "Alabama", "Kentucky", "Mississippi", "Tennessee", "Arkansas", "Louisiana", "Oklahoma", "Texas")
west <- c("Arizona", "Colorado", "Idaho", "Montana", "Nevada", "New Mexico", "Utah", "Wyoming", "Alaska", "California", "Hawaii", "Oregon", "Washington")

state_region <- function(state) {
  if (state %in% northeast) {
    return("Northeast")
  }
  else if (state %in% midwest) {
    return("Midwest")
  }
  else if (state %in% south) {
    return("South")
  }
  else if (state %in% west) {
    return("West")
  }
  else {
    return(NA)
  }
}

state_month_percentile_mean <- state_month_percentile_mean %>% 
  mutate(region=lapply(state,state_region)) 

state_month_percentile_mean_clean <- state_month_percentile_mean %>%
  mutate(mean_percentile=case_when(
    mean_percentile==999 ~ NaN,
    mean_percentile>=100 ~ 100,
    TRUE ~ mean_percentile
  ))

# export clean data -------------------------------------------------------

export(state_month_percentile_mean_clean,here::here("clean_data/wastewater_clean.csv"))

