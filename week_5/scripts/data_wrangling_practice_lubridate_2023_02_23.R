### Today we are going to practice data wrangle using lubridate package ####
### Created by: Avetis Mishegyan #############
### Created on: 2023-02-23 ####################


#### Load Libraries ######
library(tidyverse)
library(here)
library(lubridate) # package to deal with dates and times
library(devtools)
library(CatterPlots)


### Load data ######
# Environmental data from each site
cond_data <- read_csv(here("week_5","data", "CondData.csv"))
View(cond_data) # view opens a new window to view the data
glimpse(cond_data) # glimpse allows us to inspect the data


### Data Analysis ######
# Data wrangling: lubridate dates and times
# Slide - 6
now() #what time is it now?
now(tzone = "EST") # what time is it on the east coast
now(tzone = "GMT") # what time in GMT

# Slide - 7
today() # just the date
today(tzone = "GMT")
am(now()) # is it morning?
leap_year(now()) # is it a leap year?

# Slide - 9
ymd("2021-02-24") # these will all produce the same results as ISO dates
mdy("02/24/2021") # these will all produce the same results as ISO dates
mdy("February 24 2021") # these will all produce the same results as ISO dates
dmy("24/02/2021") # these will all produce the same results as ISO dates

# Slide - 11
ymd_hms("2021-02-24 10:22:20 PM")
mdy_hms("02/24/2021 22:22:20")
mdy_hm("February 24 2021 10:22 PM")

# Slide - 12, 13, 14, 15, 16, 17, 18, 19, 20, 21
datetimes<-c("02/24/2021 22:22:20", # makes a character string
             "02/25/2021 11:21:10",
             "02/26/2021 8:01:52")
datetimes <- mdy_hms(datetimes) # converts to datetimes
datetimes
month(datetimes) # extracts the months from the character string
month(datetimes, label = TRUE) # converts month number to month name
month(datetimes, label = TRUE, abbr = FALSE) # spells out month name

day(datetimes) # extracts days
wday(datetimes, label = TRUE) # extracts day of week

hour(datetimes) # extracts hour, minute, second
minute(datetimes)
second(datetimes)

datetimes + hours(4) # this adds 4 hours
datetimes + days(2) # this adds 2 days
# You can do the same with minutes(), seconds(), months(), years(), etc

round_date(datetimes, "minute") # round to nearest minute
round_date(datetimes, "5 mins") # round to nearest 5 minute
# You can do this with any set of times

# Slide - 22
cond_data %>% mutate(Date = mdy_hm(Date))
View(cond_data)

# Today's totally awesome R package
x <-c(1:10)# make up some data
y<-c(1:10)
catplot(xs=x, ys=y, cat=3, catcolor='blue')
