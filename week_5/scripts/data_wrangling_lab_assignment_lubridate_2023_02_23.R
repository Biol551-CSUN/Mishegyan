### Today we are going to data wrangle using lubridate package for lab ####
### Created by: Avetis Mishegyan #############
### Created on: 2023-02-23 ####################


#### Load Libraries ######
library(tidyverse)
library(here)
library(lubridate) # package to deal with dates and times
library(alphonse)


### Load data ######
# Environmental data from each site
cond_data <- read_csv(here("week_5","data", "CondData.csv"))
View(cond_data) # view opens a new window to view the data
glimpse(cond_data) # glimpse allows us to inspect the data

depth_data <- read_csv(here("week_5","data", "DepthData.csv"))
View(depth_data)
glimpse(depth_data)


### Data Analysis ######
cond_data_iso <- cond_data %>% 
  mutate(date = mdy_hms(date), # mutates dates to iso format
         date = round_date(date, "10 secs")) # mutates seconds to the nearest 10 seconds
View(cond_data_iso)

cond_depth_data <- inner_join(cond_data_iso, depth_data) # only keeps the data that is complete in both data sets
View(cond_depth_data)

cond_depth_means <- cond_depth_data %>%
  mutate(date = round_date(date, "min")) %>% # mutates minutes to the nearest minute
  group_by(date) %>%
  summarise(mean_temp = mean(Temperature, na.rm = TRUE),
            mean_serial = mean(Serial, na.rm = TRUE),
            mean_salinity = mean(Salinity, na.rm = TRUE),
            mean_pressure = mean(AbsPressure, na.rm = TRUE),
            mean_depth = mean(Depth, na.rm = TRUE))
View(cond_depth_means)

cond_depth_means %>%
  ggplot(mapping = aes(x = date,
                       y = mean_temp)) +
    geom_line() +
      labs(x = "Time of Day (UTC)",
           y = "Mean Temp (°C) ",
           title = "Average Temp v. Time of Day",
           color = alphonse("onepiece")) +
  theme(plot.title = element_text(hjust = .5)) + # centers plot title
  theme_classic() +
  scale_color_manual(values = alphonse("onepiece")) # sets One Piece color palette

ggsave(here("week_5","output","data_wrangling_lab_assignment_lubridate_2023_02_23.png"), # names and saves ggplot
       width = 5, height = 5) # adjust size of graph in inches
