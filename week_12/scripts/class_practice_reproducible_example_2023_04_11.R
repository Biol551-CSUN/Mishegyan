### Today we are going to practice making a reproducible example to ask for help ####
### Created by: Avetis Mishegyan #############
### Created on: 2023-04-11 ####################


#### Load Libraries ######
library(tidyverse)
library(reprex) # for reproducible example
library(datapasta) # for copy and paste
library(styler) # copy and paste in style


### Load Data ######
# Datapasta - pg 35
# Copy the text and go to Addins -> paste as tribble and then name it something
data <- tibble::tribble(
    ~lat,    ~long, ~star_no,
  33.548, -117.805,      10L,
  35.534, -121.083,       1L,
  39.503, -123.743,      25L,
  32.863,  -117.24,      22L,
   33.46, -117.671,       8L
  )


### Data Analysis ######
# Making your first reprex - pg 33
mpg %>%
  ggplot(aes(x = displ, y = hwy))%>%
  geom_point(aes(color = class))

# Go to Addins -> Render Reprex -> Paste to the program you want.
# Make sure to "append session info"Make sure to "append session info"

### Today we are going to practice functional programming ####
### Created by: Avetis Mishegyan #############
### Created on: 2023-04-04 ####################


#### Load Libraries ######
library(tidyverse)
library(reprex) # for reproducible example
#> Warning: package 'reprex' was built under R version 4.2.3
library(datapasta) # for copy and paste
#> Warning: package 'datapasta' was built under R version 4.2.3
library(styler) # copy and paste in style
#> Warning: package 'styler' was built under R version 4.2.3


### Load Data ######
tibble::tribble(
  ~lat,    ~long, ~star_no,
  33.548, -117.805,      10L,
  35.534, -121.083,       1L,
  39.503, -123.743,      25L,
  32.863,  -117.24,      22L,
  33.46, -117.671,       8L
)
#> # A tibble: 5 × 3
#>     lat  long star_no
#>   <dbl> <dbl>   <int>
#> 1  33.5 -118.      10
#> 2  35.5 -121.       1
#> 3  39.5 -124.      25
#> 4  32.9 -117.      22
#> 5  33.5 -118.       8


### Data Analysis ######
# Making your first reprex - pg 33
mpg %>%
  ggplot(aes(x = displ, y = hwy))%>%
  geom_point(aes(color = class))
#> Error in `geom_point()`:
#> ! `mapping` must be created by `aes()`
#> ℹ Did you use `%>%` or `|>` instead of `+`?
#> Backtrace:
#>     ▆
#>  1. ├─mpg %>% ggplot(aes(x = displ, y = hwy)) %>% ...
#>  2. └─ggplot2::geom_point(., aes(color = class))
#>  3.   └─ggplot2::layer(...)
#>  4.     └─ggplot2:::validate_mapping(mapping, call_env)
#>  5.       └─cli::cli_abort(msg, call = call)
#>  6.         └─rlang::abort(...)

#