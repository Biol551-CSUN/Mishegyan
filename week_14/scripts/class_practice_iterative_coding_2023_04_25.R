### Today we are going to practice iterative coding ####
### Created by: Avetis Mishegyan #############
### Created on: 2023-04-25 ####################


#### Load Libraries ######
library(tidyverse)
library(here)
library(gganatogram) # Totally awesome R package


### Load Data ######



### Data Analysis ######
# Simple for loop - pg 7, 8, 9, and 10
print(paste("The year is", 2000)) # prints quote space year

years <- c(2015:2021)
for (i in years){ # sets up the for loop where i is the index, i can be anything
  print(paste("The year is", i)) # loops over i
}

# Pre-allocate space for the for loop
year_data <- data.frame(matrix(ncol = 2, nrow = length(years))) # creates empty matrix
colnames(year_data) <- c("year", "year_name") # adds column names
year_data

for (i in 1:length(years)){ # sets up the for loop where i is the index
  year_data$year_name[i] <- paste("The year is", years[i]) # loop over i
}
year_data

for (i in 1:length(years)){ # sets up the for loop where i is the index
  year_data$year_name[i] <- paste("The year is", years[i]) # loops over year name
  year_data$year[i]<-years[i] # loops over year
}
year_data

# Using loops to read in multiple .csv files - pg 11
testdata<-read_csv(here("week_14", "data", "cond_data","011521_CT316_1pcal.csv"))
glimpse(testdata)

# List files in a directory - pg 12

CondPath <- here("week_14", "data", "cond_data") # points to the location on the computer of the folder

# list all the files in that path with a specific pattern
# In this case we are looking for everything that has a .csv in the filename

files <- dir(path = CondPath, pattern = ".csv") # you can use regex to be more specific if you are looking for certain patterns in filenames
files

# Pre-allocate space for the loop - pg 13
# pre-allocate space
# make an empty dataframe that has one row for each file and 3 columns
cond_data <- data.frame(matrix(nrow = length(files), ncol = 3))
# give the dataframe column names
colnames(cond_data) <- c("filename","mean_temp", "mean_sal")
cond_data

# For loop - pg 14
raw_data <- read_csv(paste0(CondPath,"/",files[1])) # test by reading in the first file and see if it works
head(raw_data)

mean_temp <- mean(raw_data$Temperature, na.rm = TRUE) # calculate a mean
mean_temp

# Turn it into a for loop - pg 15
for (i in 1:length(files)){ # loop over 1:3 the number of files
}

for (i in 1:length(files)){ # loop over 1:3 the number of files 
  raw_data <- read_csv(paste0(CondPath,"/",files[i]))
  glimpse(raw_data)
}

# Add in the columns - pg 16
for (i in 1:length(files)){ # loop over 1:3 the number of files 
  raw_data <- read_csv(paste0(CondPath,"/",files[i]))
  #glimpse(raw_data)
  cond_data$filename[i]<-files[i]
} 
cond_data

# Add in means - pg 17
for (i in 1:length(files)){ # loop over 1:3 the number of files 
  raw_data<-read_csv(paste0(CondPath,"/",files[i]))
  #glimpse(raw_data)
  cond_data$filename[i] <- files[i]
  cond_data$mean_temp[i] <- mean(raw_data$Temperature, na.rm =TRUE)
  cond_data$mean_sal[i] <- mean(raw_data$Salinity, na.rm =TRUE)
} 
cond_data

# Simple example - pg 20 & 21
1:10 # creates a vector from 1 to 10 (we are going to do this 10 times)

1:10 %>% # creates a vector from 1 to 10 (we are going to do this 10 times) %>% # the vector to iterate over
  map(rnorm, n = 15) # calculates 15 random numbers based on a normal distribution in a list

1:10 %>% # creates a vector from 1 to 10 (we are going to do this 10 times) %>% # the vector to iterate over
  map(rnorm, n = 15)  %>% # calculates 15 random numbers based on a normal distribution in a list 
  map_dbl(mean) # calculates the mean. It is now a vector which is type "double"

# Same thing different notation... - pg 22
1:10 %>% # list 1:10
  map(function(x) rnorm(15, x)) %>% # makes your own function
  map_dbl(mean)

1:10 %>%
  map(~ rnorm(15, .x)) %>% # changes the arguments inside the function
  map_dbl(mean)

# Bring in files using purrr instead of a for loop - pg 23
# point to the location on the computer of the folder
CondPath <- here("week_14", "data", "cond_data")
files <- dir(path = CondPath,pattern = ".csv")
files

files <- dir(path = CondPath,pattern = ".csv", full.names = TRUE) # save the entire path name
files

# Read in the files - 24
data <- files %>%
  set_names() %>% # set's the id of each list to the file name
  map_df(read_csv,.id = "filename") # maps everything to a dataframe and put the id in a column called filename
data

# Calculate means - 25
data <- files %>%
  set_names() %>% # set's the id of each list to the file name
  map_df(read_csv,.id = "filename") %>% # maps everything to a dataframe and put the id in a column called filename
  group_by(filename) %>%
  summarise(mean_temp = mean(Temperature, na.rm = TRUE),
            mean_sal = mean(Salinity,na.rm = TRUE))
data

# Totally awesome R package
gganatogram(data = hgFemale_key, 
            organism = "human", sex = "female",
            fill = "colour", fillOutline = "#a6bddb") +
  theme_void() + 
  coord_fixed

hgMale_key %>%
  filter(type %in% "nervous_system") %>%
  gganatogram(organism = "human", sex = "male",
              fill = "colour", outline = FALSE) +
  theme_void() + 
  coord_fixed()

gganatogram(data = mmFemale_key,
            organism = "mouse", sex = "female", 
            fillOutline = "#a6bddb", fill = "colour") +
  theme_void() +
  coord_fixed()

gganatogram(data = cell_key$cell,
            organism = "cell",
            fillOutline = "#a6bddb", fill = "colour") +
  theme_void() +
  coord_fixed()