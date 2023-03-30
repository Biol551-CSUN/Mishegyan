### Today we are going to practice mapping using patchwork, ggrepel, gganimate, and magick packages ####
### Created by: Avetis Mishegyan #############
### Created on: 2023-03-28 ####################


#### Load Libraries ######
library(tidyverse)
library(here)
library(patchwork) # for bringing plots together
library(ggrepel) # for repelling labels
library(gganimate) # animations
library(magick) # for images
library(palmerpenguins)


### Load Data ######
View(palmerpenguins)
View(mtcars)

### Data Analysis ######
# patchwork package
# plot 1
p1<-penguins %>%
  ggplot(aes(x = body_mass_g, 
             y = bill_length_mm, 
             color = species))+
  geom_point()
p1

# plot 2
p2<-penguins %>%
  ggplot(aes(x = sex, 
             y = body_mass_g, 
             color = species))+
  geom_jitter(width = 0.2)
p2

p1 + p2 + # brings the plots together using simple operations using patchwork
  plot_layout(guides = 'collect') + # groups the legends using patchwork
  plot_annotation(tag_levels = 'A') # adds labels (A,B) using patchwork

p1/p2 + # put one plot on top of the other using patchwork
  plot_layout(guides = 'collect')+
  plot_annotation(tag_levels = 'A')

# ggrepel package
ggplot(mtcars, aes(x = wt, 
                   y = mpg, 
                   label = rownames(mtcars))) +
  geom_text() + # creates a text label
  geom_point(color = 'red')

ggplot(mtcars, aes(x = wt, 
                   y = mpg, 
                   label = rownames(mtcars))) +
  geom_text_repel() + # repels text using ggrepel
  geom_point(color = 'red')

ggplot(mtcars, aes(x = wt, 
                   y = mpg, 
                   label = rownames(mtcars))) +
  geom_label_repel() + # repel labels using ggrepel
  geom_point(color = 'red')

# gganimate package
# static plot
penguins %>%
  ggplot(aes(x = body_mass_g, 
             y = bill_depth_mm, 
             color = species)) +
  geom_point()

penguins %>%
  ggplot(aes(x = body_mass_g, 
             y = bill_depth_mm, 
             color = species)) +
  geom_point() +
  transition_states(
    year, # what are we animating by
    transition_length = 2, # the relative length of the transition.
    state_length = 1) # the length of the pause between transitions

penguins %>%
  ggplot(aes(x = body_mass_g, 
             y = bill_depth_mm, 
             color = species)) +
  geom_point() +
  transition_states(
    year,
    transition_length = 2,
    state_length = 1) +
  ease_aes("bounce-in-out") # changes the ease aesthetics

penguins %>%
  ggplot(aes(x = body_mass_g, 
             y = bill_depth_mm, 
             color = species)) +
  geom_point() +
  transition_states(
    year,
    transition_length = 2,
    state_length = 1) +
    ease_aes("sine-in-out") +
  ggtitle('Year: {closest_state}') + # adds a transition title
  anim_save(here("week_10","output","mypengiungif.gif")) # Saves it as a .gif

# magick package
penguin <- image_read("https://pngimg.com/uploads/penguin/pinguin_PNG9.png") # reads in an image of a penguin (can be on your computer or the internet).
penguin
ggsave(here("week_10","output","pinguin_PNG9.png")) # names and saves photo

penguins %>%
  ggplot(aes(x = body_mass_g, 
             y = bill_depth_mm, 
             color = species)) +
  geom_point()

penplot <- image_read(here("week_10","output","penguinplot.png"))
out <- image_composite(penplot, penguin, offset = "+70+30") # layers in order
out