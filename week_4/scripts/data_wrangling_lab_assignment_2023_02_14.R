### Today we are going to data wrangle penguin data as a group####
### Created by: Avetis Mishegyan #############
### Updated on: 2023-02-14 ####################


#### Load Libraries ######
library(palmerpenguins)
library(tidyverse)
library(here)


### Load data ######
# The data is part of the package and is called penguins
# Glimpse allows us to inspect the data
glimpse(penguins)



### Data Analysis ######
head(penguins)
tail(penguins)



# Assignment Part 1
assignment_1 <- penguins %>% 
  drop_na(species, island, sex) %>% # drops all NA's in species, island, and sex
  group_by(species, island, sex) %>% # groups by so that you can summarize values by certain groups.
  summarise(mean_body_mass_g = mean(body_mass_g, na.rm = TRUE), # summarise allows calcs. like mean and variance
            variance_body_mass_g = var(body_mass_g, na.rm = TRUE))
View(assignment_1)

# Assignment Part 2
assignment_2 <- penguins %>%
  drop_na(sex, body_mass_g) %>% # Drops all NA's in sex and body mass
  filter(sex != "male") %>% # Excludes males data
  select(Island = island, # selects columns (shortens columns to only the ones mentioned in order)
            Sex = sex,
            Species = species,
            Body_Mass_g = body_mass_g) %>%
  mutate(Log_Body_Mass_g = log(Body_Mass_g)) %>% # allows for calcs. on each row within a column
  ggplot(mapping = aes(x = Island, # sets log (Body Mass) as a function of island
                       y = Log_Body_Mass_g,
                       color = Species)) +
    geom_boxplot() + # plots log (Body Mass) as a function of island using a box plot graph
    geom_jitter(alpha = .4, # plots log (Body Mass) as a function of island using a jitter plot graph
                position = position_dodge(width = 0.7)) +
      labs(y = "log(Body Mass) (g)",
           x = "Island",
           title = "Body Mass of Females Penguins",
           fill = "Species") +
      theme(plot.title = element_text(hjust = .5)) # centers graph title

assignment_2

ggsave(here("week_4","output","data_wrangling_lab_assignment_part2_2023_02_14.R.png"),
       width = 7, height = 5) # adjust size of graph in inches
