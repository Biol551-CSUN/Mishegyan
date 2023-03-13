### Today we are going to practice mapping using the maps, mapproj, mapdata packages ####
### Created by: Avetis Mishegyan #############
### Created on: 2023-03-07 ####################


#### Load Libraries ######
library(tidyverse)
library(here)
library(maps) # package is a combination of functions that pair well with ggplot 
# and base layers for maps (i.e. polygons of regions of interest)
library(mapdata) # the function used to pull out whatever base layer that you want
library(mapproj) # package includes different map projections
library(ggdogs) # total Awesome R package


### Load data ######
# Reads in data on population in California by county
popdata <- read_csv(here("week_7","data","CApopdata.csv")) # reads in our data
View(popdata) # view opens a new window to view the data
glimpse(popdata) # glimpse allows us to inspect the data

# Reads in data on number of seastars at different field sites
stars <- read_csv(here("week_7","data","stars.csv"))
View(stars)
glimpse(stars)


### Data Analysis ######
world <- map_data("world") # get data for the entire world
head(world)

usa <- map_data("usa") # get data for the USA
head(usa)

italy<-map_data("italy") # get data for italy
head(italy)

states<-map_data("state") # get data for states
head(states)

counties<-map_data("county") # get data for counties
head(counties)

ggplot() +
  geom_polygon(data = world,
               aes(x = long,
                   y = lat,
                   group = group))

ggplot() +
  geom_polygon(data = world,
               aes(x = long,
                   y = lat)) # happens if you forget group = group

ggplot()+
  geom_polygon(data = world,
               aes(x = long, 
                   y = lat,
                   group = group),
               color = "blue") # adds color to the lines

ggplot()+
  geom_polygon(data = world,
               aes(x = long, 
                   y = lat,
                   group = group,
                   fill = region), # adds color fill
               color = "black") +
  guides(fill = FALSE) + # removes legend
  theme_minimal() # sets theme to minimal

ggplot()+
  geom_polygon(data = world,
               aes(x = long, 
                   y = lat,
                   group = group,
                   fill = region),
               color = "black") +
  guides(fill = FALSE) +
  theme_minimal() +
  theme(panel.background = element_rect(fill = "lightblue")) # makes the ocean blue

ggplot()+
  geom_polygon(data = world,
               aes(x = long, 
                   y = lat,
                   group = group,
                   fill = region),
               color = "black") +
  guides(fill = FALSE) +
  theme_minimal() +
  theme(panel.background = element_rect(fill = "lightblue")) +
  coord_map(projection = "mercator", # uses a mercator projection
            xlim = c(-180,180))

ggplot()+
  geom_polygon(data = world,
               aes(x = long, 
                   y = lat,
                   group = group,
                   fill = region),
               color = "black") +
  guides(fill = FALSE) +
  theme_minimal() +
  theme(panel.background = element_rect(fill = "lightblue")) +
  coord_map(projection = "sinusoidal", # uses a sinusoidal projection
          xlim = c(-180,180))

# Assignment - Slide 22 - Start
head(states) # uses the states dataset

CA_data <- states %>% # uses the states dataset
  filter(region == "california") # filters out just the California data

ggplot()+
  geom_polygon(data = CA_data, 
               aes(x = long, 
                   y = lat, 
                   group = group), 
               color = "black") +
  coord_map()+
  theme_void()
# Assignment - Slide 22 - End

# Look at the county data
head(counties)[1:3,] # only showing the first 3 rows for space

# Look at the county data
head(popdata)

CApop_county <- popdata %>%
  select("subregion" = County, Population) %>% # renames the county col
  inner_join(counties) %>%
  filter(region == "california") # some counties have same names in other states

head(CApop_county)

ggplot() +
  geom_polygon(data = CApop_county,
               aes(x = long,
                   y = lat,
                   group = group,
                   fill = Population),
               color = "black") +
  coord_map() +
  theme_void()

ggplot() +
  geom_polygon(data = CApop_county,
               aes(x = long,
                   y = lat,
                   group = group,
                   fill = Population),
               color = "black") +
  coord_map() +
  theme_void() +
  scale_fill_gradient(trans = "log10") # makes it log scale for easier interpretation

head(stars)
ggplot() +
  geom_polygon(data = CApop_county,
               aes(x = long,
                   y = lat,
                   group = group,
                   fill = Population),
               color = "black") +
  geom_point(data = stars, # adds a point at all my sites
             aes(x = long,
                 y = lat)) +
  coord_map() +
  theme_void() +
  scale_fill_gradient(trans = "log10")

ggplot() +
  geom_polygon(data = CApop_county,
               aes(x = long,
                   y = lat,
                   group = group,
                   fill = Population),
               color = "black") +
  geom_point(data = stars,
             aes(x = long,
                 y = lat,
                 size = star_no)) + # makes points proportional to number of stars
  coord_map() +
  theme_void() +
  scale_fill_gradient(trans = "log10")

ggplot()+
  geom_polygon(data = CApop_county,
               aes(x = long,
                   y = lat,
                   group = group,
                   fill = Population),
               color = "black") +
  geom_point(data = stars,
             aes(x = long,
                 y = lat,
                 size = star_no)) + 
  coord_map() +
  theme_void() +
  scale_fill_gradient(trans = "log10") +
  labs(size = "# stars/m2") # makes a better legend label

ggsave(here("week_7","output","CApop.pdf"))

# Total Awesome R package
# remotes::install_github("R-CoderDotCom/ggdogs@main")
ggplot(mtcars) +
  geom_dog(aes(mpg, wt), dog = "pug", size = 5)