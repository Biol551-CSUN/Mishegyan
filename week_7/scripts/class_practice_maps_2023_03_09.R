### Today we are going to practice mapping using the maps, mapproj, mapdata packages ####
### Created by: Avetis Mishegyan #############
### Created on: 2023-03-07 ####################


#### Load Libraries ######
library(tidyverse)
library(here)
library(ggmap) # for ggmaps
library(ggsn) # to add scale bars and compass arrows
library(emojifont) # totally awesome R Package

### Load data ######
register_google(key = "Place Key Here", write = TRUE) # use your own API
# IMPORTANT don't put your key to github!! I usually save mine in a text file and import it each time
# Setting write = TRUE will write the API key to your R environment so that you do not have to re register it each time

ChemData <- read_csv(here("week_7","data","chemicaldata_maunalua.csv")) # reads in our data
glimpse(ChemData) # glimpse allows us to inspect the data

Oahu <- get_map("Oahu") # sets map data
ggmap(Oahu) # plots and shows map

# Make a data frame of lon and lat coordinates
WP <- data.frame(lon = -157.7621, lat = 21.27427) # coordinates for Wailupe
Map1 <- get_map(WP) # gets base layer
ggmap(Map1)

Map1 <- get_map(WP, zoom = 17) # zoom = zooms in, zoom scale from 3 to 20
ggmap(Map1)

Map1 <- get_map(WP, zoom = 17, maptype = "satellite") # maptype = changes the map type
ggmap(Map1)

Map1 <- get_map(WP,zoom = 17, maptype = "watercolor")
ggmap(Map1)

# You can use the ggmap base layer in any ggplot
Map1 <- get_map(WP,zoom = 17, 
                maptype = "satellite") 
ggmap(Map1) +
  geom_point(data = ChemData,
             aes(x = Long,
                 y = Lat,
                 color = Salinity),
             size = 4) +
  scale_color_viridis_c()

# Adds a scale bar
ggmap(Map1) +
  geom_point(data = ChemData, 
             aes(x = Long,
                 y = Lat,
                 color = Salinity), 
             size = 4) + 
  scale_color_viridis_c() +
  scalebar(x.min = -157.766, x.max = -157.758,
            y.min = 21.2715, y.max = 21.2785,
            dist = 250, dist_unit = "m", model = "WGS84", 
            transform = TRUE, st.color = "white",
            box.fill = c("yellow", "white"))

# Use geocode() to get exact locations that you can then use in the maps.
geocode("the white house")
geocode("California State University, Northridge")

# Totally awesome R Package
search_emoji('smile') # searches emoji types with smile in name
ggplot() + 
  geom_emoji('smile_cat', 
             x=1:5,
             y=1:5, 
             size=10)