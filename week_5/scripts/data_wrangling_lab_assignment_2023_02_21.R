### Today we are going to practice data wrangle using joins function ####
### Created by: Avetis Mishegyan #############
### Created on: 2023-02-21 ####################


#### Load Libraries ######
library(tidyverse)
library(here)


### Load data ######
# tibble 1
T1 <- tibble(islands = c("thriller_bark", "mary_geoise", "impel_down", "drum_island", "wano"),
             temperature = c(14.1, 16.7, 15.3, 12.8, 30.2))
head(T1)

# tibble 2
T2 <-tibble(islands = c("thriller_bark", "mary_geoise", "impel_down", "drum_island", "laugh_tale"), 
            pH = c(7.3, 7.8, 8.1, 7.9, 10.2))
head(T2)

# left_join
num1 <- left_join(T1, T2) # keeps all islands from 1st table and matches islands from 2nd table,
head(num1) # but removes new islands and their values

# right_join
num2<- right_join(T1, T2) # same as left join. but the opposite table
head(num2)

# inner_join
num3 <- inner_join(T1, T2) # only keeps the data that is complete in both data sets
head(num3)

# full_join
num4 <- full_join(T1, T2) # keeps data from both data
head(num4)

# semi_join
num5 <- semi_join(T1, T2) # semi_join keeps all rows from the first data set where there are matching 
head(num5)                # values in the second data set, keeping just columns from the first data set.


# anti_join
num6 <- anti_join(T1, T2) # Saves all rows in the first data set that do not match anything in the 
head(num6)                # second data set. This can help you find possible missing data across data sets.