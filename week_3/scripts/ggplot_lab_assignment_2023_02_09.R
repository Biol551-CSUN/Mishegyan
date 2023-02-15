### Today we are going to plot penguin data as a group ####
### Created by: Avetis Mishegyan #############
### Updated on: 2023-02-9 ####################


#### Load Libraries ######
library(palmerpenguins)
library(tidyverse)
library(here)
library(beyonce)
library(ggthemes)


### Load data ######
# the data is part of the package and is called penguins
glimpse(penguins) # glimpse helps inspect the the penguin data


### Data Analysis ######
penguins_summary <- penguins %>%
  group_by(species, sex) %>% # changes functions to operate on group by group data rather than the entire dataset
  na.omit() %>% # omits NA data
  summarise(flipper_size = mean(flipper_length_mm)) # collapses a data frame into a single row
    
ggplot(data = penguins_summary,
       mapping = aes(x = species,
                     y = flipper_size,
                     fill = sex)) + # adds color to legend
  geom_bar(position = "dodge2", # adds spaces btw grouped bars
           stat = "identity") + 
  labs(x = "Species",
       y = "Flipper Length (mm)",
       title = "Flipper Length of Males v. Females Penguins",
       fill = "Sex") +
  theme(plot.title = element_text(hjust = .5)) + # centers plot title
  scale_fill_manual(values = beyonce_palette(72)) # adds beyonce color palette to bars

ggsave(width = 5, height = 5, dpi = 300, filename = "group_penguin_plot_2023_02_09.png") # adjusts size of plot, and saves it