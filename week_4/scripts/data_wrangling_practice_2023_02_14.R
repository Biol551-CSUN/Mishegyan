### Today we are going to data wrangle penguin data ####
### Created by: Avetis Mishegyan #############
### Updated on: 2023-02-14 ####################


#### Load Libraries ######
library(palmerpenguins)
library(tidyverse)
library(here)
library(devtools) # load the development tools library
library(dadjokeapi)


### Load data ######
# the data is part of the package and is called penguins
# glimpse allows us to inspect the data
glimpse(penguins)

### Data Analysis ######
head(penguins)
tail(penguins)

filter(.data = penguins, sex == "female") # == asks "is sex equal to female?" (returns TRUE/FALSE and keeps TRUE)
                                          # while = is a statement saying "this is that"


filter(.data = penguins, sex == "female", body_mass_g > 5000) # 1st way of filtering by 2 aspects


filter(.data = penguins, sex == "female" & body_mass_g > 5000) # 2nd way of filtering by 2 aspects


filter(.data = penguins, year == "2008" | year == "2008") # question 1 - slide 19
filter(.data = penguins, year %in% c("2008", "2009")) # question 1 - slide 19 alternative
filter(.data = penguins, island != "Dream") # question 2 - slide 19
filter(.data = penguins, species == "Adelie" | species == "Gentoo") # question 3 - slide 19


data2 <- mutate(.data = penguins, 
                body_mass_kg = body_mass_g/1000) # converts body mass from g to kg in a new column
View(data2)
data2 <- mutate(.data = penguins, 
              body_mass_kg = body_mass_g/1000,
              bill_length_depth = bill_length_mm/bill_depth_mm) # calculates the ratio of bill length to depth
View(data2)


data2 <- mutate(.data = penguins,
                after_2008 = ifelse(year > "2008", "After 2008", "Before 2008"))
View(data2)


sum_length_and_mass <- mutate(.data = penguins,
                              length_and_mass = body_mass_g + flipper_length_mm) # question 1 - slide 28
body_mass_4000 <- mutate(.data = penguins,
                         body_mass_greater = ifelse(body_mass_g > 4000, "big", "small")) # question 2 - slide 28

# %>% the "pipe" says "and then do"
# %>% vs |> - magrittr (from the tidyverse) vs native (new pipe that comes with base R so you don't need to load any libraries)
penguins %>% # use penguin dataframe
  filter(sex == "female") %>% # select females
  mutate(log_mass = log(body_mass_g)) # calculate log biomass


penguins %>% # use penguin dataframe
  filter(sex == "female") %>% # selects females only (shortens within column)
  mutate(log_mass = log(body_mass_g)) %>% # calculates log biomass
  select(species, island, sex, log_mass) # selects columns (shortens columns to only the ones mentioned in order)
penguins %>%
  filter(sex == "female") %>%
  mutate(log_mass = log(body_mass_g)) %>%
  select(Species = species, island, sex, log_mass) # capitalizes "S" in species


penguins %>%
  summarise(mean_flipper = mean(flipper_length_mm, na.rm = TRUE)) # summarise allows use to calc. things like means
penguins %>% # 
  summarise(mean_flipper = mean(flipper_length_mm, na.rm=TRUE), # summarise by mean and min
            min_flipper = min(flipper_length_mm, na.rm=TRUE))


penguins %>%
  group_by(island) %>% # allows for summaries by island rather than all islands
  summarise(mean_bill_length = mean(bill_length_mm, na.rm = TRUE),
            max_bill_length = max(bill_length_mm, na.rm=TRUE))

penguins %>%
  group_by(island, sex) %>% # allows for summaries by island and sex rather than all islands and sex
  summarise(mean_bill_length = mean(bill_length_mm, na.rm = TRUE),
            max_bill_length = max(bill_length_mm, na.rm=TRUE))
## summarise() has grouped output by 'island'. You can override using the
## .groups argument.


penguins %>%
  drop_na(sex) # drop all the rows that are missing data on sex


penguins %>% # drop all the rows that are missing data on sex calculate mean bill length by sex
  drop_na(sex) %>%
  group_by(island, sex) %>%
  summarise(mean_bill_length = mean(bill_length_mm, na.rm = TRUE))
## summarise() has grouped output by 'island'. You can override using the
## .groups argument.


penguins %>% # Drop NAs from sex, and then plot boxplots of flipper length by sex
  drop_na(sex) %>%
  ggplot(aes(x = sex, y = flipper_length_mm)) +
  geom_boxplot()


groan()