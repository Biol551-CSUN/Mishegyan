### Today we are going to data wrangle provided chemical data as a group####
### Created by: Avetis Mishegyan #############
### Updated on: 2023-02-16 ####################


#### Load Libraries ######
library(tidyverse)
library(here)
library(alphonse)


### Load data ######
ChemData <- read_csv(here("week_4", "data", "chemicaldata_maunalua.csv"))
View(ChemData) # view opens a new window to view the data
glimpse(ChemData) # glimpse allows us to inspect the data


### Data Analysis ######

# Assignment Part 1
ChemData_assignment1 <- ChemData %>%
  drop_na() %>% # filters out everything that is not a complete row
  separate(col = Tide_time, # choose the tide time columns
           into = c("Tide", "Time"), # separates it into two columns Tide and time
           sep = "_") %>% # separates by _
  filter(Season == "SPRING") %>% # filters by the spring season
  pivot_longer(cols = Temp_in:percent_sgd, # the columns you want to pivot. This says select the temp to percent SGD columns
               names_to = "Variables", # the names of the new columns with all the column names
               values_to = "Values") %>% # names of the new column with all the values 
  group_by(Variables,  Site, Zone) %>% # groups variables by site and zone
  summarise(mean_vals = mean(Values, na.rm = TRUE),
            sd_vals = sd(Values, na.rm = TRUE)) %>%
  pivot_wider(names_from = Site,
              values_from = c(mean_vals, sd_vals)) %>% # now mean_vals_site as their own column name
  drop_na() %>% # drops offshore NA's
  write_csv(here("week_4", "output", "data_wrangling_lab_assignment_part1_2023_02_16.csv")) # export as a csv to the right folder

View(ChemData_assignment1)

# Assignment Part 2
ChemData_assignment2 <- ChemData %>%
  drop_na() %>% # filters out everything that is not a complete row
  separate(col = Tide_time, # choose the tide time columns
           into = c("Tide", "Time"), # separates it into two columns Tide and time
           sep = "_") %>% # separates by _
  filter(Zone != "Offshore") %>% # keeps all rows that don't contain Offshore site
  ggplot(mapping = aes(x = Site,
                       y = Zone,
                       fill = pH)) +
    geom_tile() + # heat map function
      labs(x = "Site",
           y = "Zone",
           fill = "pH",
           title = "pH Levels by Site and Zone for Submarine Groundwater") +
      theme(plot.title = element_text(hjust = .5)) + # centers plot title
      theme_classic() +
      scale_fill_gradient(low = "white", high = "blue") # sets heat map colors
#  scale_fill_gradient(values = alphonse("onepiece", low = "#d0c0b0", high = "#b32929"))

ChemData_assignment2

ggsave(here("week_4","output","data_wrangling_lab_assignment_part2_2023_02_16.R.png"),
       width = 6, height = 5) # adjust size of graph in inches