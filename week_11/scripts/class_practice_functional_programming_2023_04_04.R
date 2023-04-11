### Today we are going to practice functional programming ####
### Created by: Avetis Mishegyan #############
### Created on: 2023-04-04 ####################


#### Load Libraries ######
library(tidyverse)
library(palmerpenguins)
library(PNWColors) # for the PNW color palette
library(emokid) # for Today's totally awesome R package


### Load Data ######
# Why functions - pg 6
df <- tibble::tibble( # makes data frame
  a = rnorm(10), # draws 10 random values from a normal distribution
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10))
head(df)


### Data Analysis ######
# Why functions - pg 7
df<-df %>% # rescales every column individually
  mutate(a = (a-min(a, na.rm = TRUE))/(max(a, na.rm = TRUE)-min(a, na.rm = TRUE)),
         b = (b-min(b, na.rm = TRUE))/(max(b, na.rm = TRUE)-min(b, na.rm = TRUE)),
         c = (c-min(c, na.rm = TRUE))/(max(c, na.rm = TRUE)-min(c, na.rm = TRUE)),
         d = (d-min(d, na.rm = TRUE))/(max(d, na.rm = TRUE)-min(d, na.rm = TRUE)))

# We can write a function for this - pg 8
rescale01 <- function(x) {
  value<-(x-min(x, na.rm = TRUE))/(max(x, na.rm = TRUE)-min(x, na.rm = TRUE))
  return(value)
}
df %>%
  mutate(a = rescale01(a),
         b = rescale01(b),
         c = rescale01(c),
         d = rescale01(d))

# How to Make a Function - pg 9-12
# Calculation
temp_C <- (temp_F - 32) * 5 / 9

# Step 1: Name the function 
temp_f_to_c <- function() {
}

# Step 2: Put in the equation
temp_f_to_c <- function() { 
  temp_C <- (temp_F - 32) * 5 / 9
}

# Step 3: Decide what the arguments are
temp_f_to_c <- function(temp_F) {
  temp_C <- (temp_F - 32) * 5 / 9 
}

# Step 4: Decide what is being returned
temp_f_to_c <- function(temp_F) { 
  temp_C <- (temp_F - 32) * 5 / 9 
  return(temp_C)
}

# Step 5: Test it
temp_f_to_c(32)
temp_f_to_c(212)

# Think, Pair, Share - pg 13
# Write a function that converts celcius to kelvin. (Remember Kelvin is celcius + 273.15)
temp_c_to_k <- function(temp_C) {
  temp_K <- (temp_C + 273.15)
  return(temp_K)
}

# Making plots into a function - pg 14
pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
ggplot(penguins, aes(x = body_mass_g, y = bill_length_mm, color = island))+
  geom_point()+
  geom_smooth(method = "lm")+ # add a linear model
  scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
  theme_bw()
temp_c_to_k(5)

# Making plots into a function - pg 16
# Name and set-up the function
myplot<-function(){
  pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
  ggplot(penguins, aes(x = body_mass_g, y = bill_length_mm, color = island))+
    geom_point()+
    geom_smooth(method = "lm")+ # add a linear model
    scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
    theme_bw()
}

# Making plots into a function - pg 17
#Make the names broad so it can be applicable to several values
myplot<-function(data, x, y){
  pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
  ggplot(data, aes(x = x, y =y , color = island))+
    geom_point()+
    geom_smooth(method = "lm")+ # add a linear model
    scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
    theme_bw()
}

# Making plots into a function - pg 18
# Making plots into a function
# Test it
# Well, shoot, I got an error.... why do we think that is?
myplot(data = penguins, x = body_mass_g, y = bill_length_mm)

# Making plots into a function - pg 19
# Need to use {{}} in aesthetics
myplot<-function(data, x, y){ 
  pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
  ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
    geom_point()+
    geom_smooth(method = "lm")+ # add a linear model
    scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
    theme_bw()
}

# Making plots into a function - pg 20
# Test it
myplot(data = penguins, x = body_mass_g, y = bill_length_mm)

# Making plots into a function - pg 21
# Test with new variables
myplot(data = penguins, x = body_mass_g, y = flipper_length_mm)

# Adding defualts - pg 22
# Let's say you want to create a default for the function to always default to the penguins dataset. You can set those directly in the function.
myplot<-function(data = penguins, x, y){
pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
  geom_point()+
  geom_smooth(method = "lm")+ # add a linear model
  scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
  theme_bw()
}

# Adding defualts - pg 23
# Test it
myplot(x = body_mass_g, y = flipper_length_mm)

# Layering the plot - pg 24
# You can also layer onto your plot using '+' just like it is a regular ggplot to change things like labels.
myplot(x = body_mass_g, y = flipper_length_mm)+
  labs(x = "Body mass (g)",
       y = "Flipper length (mm)")

# Add an if-else statement for more flexibility - pg 25
# An aside on if-else statements....
# Imagine you want a variable to be equal to a certain value if a condition is met.
# This is a typical problem that requires the if ... else ... construct. For instance:
a <- 4
b <- 5

# Suppose that if a > b then f should be = to 20, else f should be equal to 10. Using if/else we:
  if (a > b) { # my question
    f <- 20 # if it is true give me answer 1
  } else { # else give me answer 2
    f <- 10
  }

# When I type f I get...
f

# Back to plotting - pg 26
myplot<-function(data = penguins, x, y ,lines=TRUE ){ # add new argument for lines
  pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
  ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
    geom_point()+
    geom_smooth(method = "lm")+ # add a linear model
    scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
    theme_bw()
}

# If-else - pg 27
myplot<-function(data = penguins, x, y, lines=TRUE ){ # add new argument for lines
  pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
  if(lines==TRUE){
    ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
      geom_point()+
      geom_smooth(method = "lm")+ # add a linear model
      scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
      theme_bw()
  }
  else{
    ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
      geom_point()+
      scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
      theme_bw()
  }
}

# Test it - 28
# With line
myplot(x = body_mass_g, y = flipper_length_mm)

# Test it - 29
# Without line
myplot(x = body_mass_g, y = flipper_length_mm, lines = FALSE)

# Today's totally awesome R package
iamsad() # when sad
iamlesssad() # when less sad
mymood() # an emoji for your mood