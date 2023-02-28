### Today we are going to practice data wrangle using joins function ####
### Created by: Avetis Mishegyan #############
### Created on: 2023-02-21 ####################


#### Load Libraries ######
library(tidyverse)
library(here)
library(cowsay)


### Load data ######
# Environmental data from each site
EnviroData<-read_csv(here("Week_5","data", "site.characteristics.data.csv"))
View(EnviroData) # view opens a new window to view the data
glimpse(EnviroData) # glimpse allows us to inspect the data

#Thermal performance data
TPCData<-read_csv(here("Week_5","data","Topt_data.csv"))
View(TPCData)
glimpse(TPCData)


### Data Analysis ######
EnviroData_wide <- EnviroData %>% 
  pivot_wider(names_from = parameter.measured, # pivots data from long to wide
              values_from = values)

View(EnviroData_wide)

EnviroData_wide <- EnviroData %>% 
  pivot_wider(names_from = parameter.measured,
              values_from = values) %>%
  arrange(site.letter) # arrange the dataframe by site

View(EnviroData_wide)

FullData_left <- left_join(TPCData, EnviroData_wide)
## Joining with by = join_by(site.letter)

head(FullData_left)

FullData_left<- left_join(TPCData, EnviroData_wide) %>%
  relocate(where(is.numeric), .after = where(is.character)) # relocate all the numeric data after the character data
## Joining with by = join_by(site.letter)

head(FullData_left)

# Assignment 1 - slide 17 - start
FullData_left<- left_join(TPCData, EnviroData_wide) %>%
  relocate(where(is.numeric), .after = where(is.character)) %>%
  pivot_longer(cols = E:substrate.cover,
               names_to = "variables",
               values_to = "values") %>%
  group_by(site.letter, variables) %>%
  summarise(mean_vals = mean(values, na.rm = TRUE),
            var_vals= var(values, na.rm = TRUE))

View(FullData_left)
# Assignment 1 - slide 17 - end

# Make 1 tibble - start
T1 <- tibble(Site.ID = c("A", "B", "C", "D"), 
             Temperature = c(14.1, 16.7, 15.3, 12.8))
head(T1)

# Make another tibble - start
T2 <-tibble(Site.ID = c("A", "B", "D", "E"), 
            pH = c(7.3, 7.8, 8.1, 7.9))
head(T2)
# Make another tibble - end

# left_join vs right_join - start
left_join(T1, T2)
head(left_join)

right_join(T1, T2)
head(right_join)
# notice where the missing value is for each data set
# left_join vs right_join - end

# inner_join vs full_join - start
inner_join(T1, T2)
head(inner_join)

full_join(T1, T2)
head(full_join)
# inner_join vs full_join - end

# semi_join vs anti_join - start
semi_join(T1, T2)
head(semi_join)

anti_join(T1, T2)
head(anti_join)
# semi_join vs anti_join - end

# Today's totally awesome R package
say("hello", by = "shark") # I want a shark to say hello
say("I want pets", by = "cat") # I want a cat to say I want pets
