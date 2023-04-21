### Today we are going to practice working with factors ####
### Created by: Avetis Mishegyan #############
### Created on: 2023-04-20 ####################


#### Load Libraries ######
library(here)
library(tidyverse)


### Load Data ######
tuesdata <- tidytuesdayR::tt_load(2021, week = 7) # reads in data using the tidytuesdayR package

income_mean <-tuesdata$income_mean
View(income_mean) # view opens a new window to view the data
glimpse(income_mean) # glimpse allows us to inspect the data


### Data Analysis ######
# What is a factor - pg 5
fruits <- factor(c("Apple", "Grape", "Banana")) # converts to a factor
fruits

# factor booby-traps! - pg 6
test <- c("A", "1", "2")
as.numeric(test)

test <- factor(test) # covert to factor
as.numeric(test)

# {forcats} - pg 8
glimpse(starwars)

# starwars - pg 9
starwars %>% 
  filter(!is.na(species)) %>% # remove the NAs
  count(species, sort = TRUE)

# starwars - pg 10
star_counts<-starwars %>%
  filter(!is.na(species)) %>% # removes NA's
  mutate(species = fct_lump(species, n = 3)) %>% # converts the data into a factor and lumps it together
  count(species)
star_counts

# reordering factors - pg 11, 12, and 13
star_counts %>%
  ggplot(aes(x = fct_reorder(species, n, .desc = TRUE), # reorder the factor of species by n in descending order
             y = n)) +
  geom_col() +
  labs(x = "Species")

# reordering line plots - pg 13, 14, 15, and 16
glimpse(income_mean)
total_income <- income_mean %>%
  group_by(year,
           income_quintile) %>%
  summarise(income_dollars_sum = sum(income_dollars)) %>%
  mutate(income_quintile = factor(income_quintile)) # makes it a factor

total_income %>%
  ggplot(aes(x = year,
             y = income_dollars_sum,
             color = income_quintile)) +
  geom_line()

total_income %>%
  ggplot(aes(x = year,
             y = income_dollars_sum, 
             color = fct_reorder2(income_quintile,year,income_dollars_sum))) +
  geom_line() +
  labs(color = "income quantile")

# reorder levels directly in a vector because I said so - pg 17
x1 <- factor(c("Jan", "Mar", "Apr", "Dec"))
x1

x1 <- factor(c("Jan", "Mar", "Apr", "Dec"), levels = c("Jan", "Mar", "Apr", "Dec")) # reorders levels
x1

# subest data with factors - pg 18 and 19
starwars_clean <- starwars %>% 
  filter(!is.na(species)) %>% # removes the NAs
  count(species, sort = TRUE) %>%
  mutate(species = factor(species)) %>% # makes species a factor
  filter(n > 3) # only keeps species that have more than 3
starwars_clean
levels(starwars_clean$species) # checks the levels of the factor

starwars_clean <- starwars %>% 
  filter(!is.na(species)) %>% # removes the NAs
  count(species, sort = TRUE) %>%
  mutate(species = factor(species)) %>% # makes species a factor 
  filter(n > 3)  %>% # only keeps species that have more than 3 
  droplevels() # drops extra levels
levels(starwars_clean$species)

# recode levels - pg 20
starwars_clean <- starwars %>% 
  filter(!is.na(species)) %>% # removes the NAs
  count(species, sort = TRUE) %>%
  mutate(species = factor(species)) %>% # makes species a factor 
  filter(n > 3)  %>% # only keeps species that have more than 3 
  droplevels() %>% # drops extra levels 
  mutate(species = fct_recode(species, "Humanoid" = "Human")) # renames human species
starwars_clean

# Today's totally awesome R package - pg 21
# {gm} (generate music)
# install.packages('gm')