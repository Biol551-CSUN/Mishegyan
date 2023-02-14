### This is my first script.  I am learning how to import data
### Created by: Avetis Mishegyan
### Created on: 2023-02-02
###############################################

### Load libraries ##########
library(tidyverse)
library(here)

### Read in data ###
weight_data <- read_csv(here("week_2", "data", "weightdata.csv"))

### Data Analysis #####
head(weight_data) # Looks at the top 6 lines of the data frame
tail(weight_data) # Looks at the bottom 6 lines of the data frame
View(weight_data) # opens a new window to look at the entire data frame
glimpse(weight_data) # shows data in an alternative way to view()

