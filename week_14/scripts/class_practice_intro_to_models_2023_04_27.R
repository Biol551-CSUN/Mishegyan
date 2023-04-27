### Today we are going to practice intro to models ####
### Created by: Avetis Mishegyan #############
### Created on: 2023-04-27 ####################


#### Load Libraries ######
library(tidyverse)
library(here)
library(palmerpenguins)
library(wesanderson) # for wesanderson data
library(broom) # for cleaning model data
library(performance) # for model assumptions
library(modelsummary) # for creating tables and plots to summarize statistical models
library(tidymodels) # for creating tidy models
library(see) # needed to run performance package
library(pushoverr) # Totally awesome R package


### Load Data ######
# wesanderson package data
# palmer penguins package data


### Data Analysis ######
# Anatomy of a basic linear model - pg 6
mod <- lm(y ~ x, data = df) # simple linear model
# lm = linear model, y = dependent variable, x = independent variable(s), df = dataframe

mod <- lm(y ~ x1 + x2, data = df) # multiple regression
mod <- lm(y ~ x1 * x2, data = df) # the * will compute x1+x2+x1:x2

# Model the penguin dataset - pg 7
# linear model of Bill depth ~ Bill length by species
Peng_mod <- lm(bill_length_mm ~ bill_depth_mm * species, data = penguins)

# Check model assumptions with performace - pg 8
check_model(Peng_mod) # checks assumptions of an lm model

# View results: base R - pg 9 & 10
anova(Peng_mod) # runs anova analysis
summary(Peng_mod) # runs coefficients (effect size) with error analysis

# View results with broom - pg 11, 12, & 13
coeffs <- tidy(Peng_mod) # tidies coefficients # just put tidy() around it
coeffs

results <- glance(Peng_mod) # tidy r2, etc
results

resid_fitted <- augment(Peng_mod) # tidy residuals, etc
resid_fitted

# Results in {modelsummary} - pg 15
# New model
Peng_mod_noX <- lm(bill_length_mm ~ bill_depth_mm, data = penguins)

#Make a list of models and name them
models <- list("Model with interaction" = Peng_mod,
               "Model with no interaction" = Peng_mod_noX)

#Save the results as a .docx
modelsummary(models, output = here("week_14","output","table.docx"))

# Modelplot - pg 16
modelplot(models) +
  labs(x = 'Coefficients', 
       y = 'Term names') +
  scale_color_manual(values = wes_palette('Darjeeling1'))

# Many models with purrr, dplyr, and broom - pg 17, 18, 18
models <- penguins %>%
  ungroup() %>% # the penguin data are grouped so we need to ungroup them
  nest(-species) # nest all the data by species
models

models <- penguins %>%
  ungroup() %>% # the penguin data are grouped so we need to ungroup them
  nest(-species) %>% # nest all the data by species 
  mutate(fit = map(data, ~lm(bill_length_mm~body_mass_g, data = .))) # maps a model to each of the groups in the list
models

models$fit # shows you each of the 3 models

results <- models %>%
  mutate(coeffs = map(fit, tidy), # looks at the coefficients
         modelresults = map(fit, glance))  # R2 and others
results

results <- models %>%
  mutate(coeffs = map(fit, tidy),
         modelresults = map(fit, glance)) %>% 
  select(species, coeffs, modelresults) %>% # only keeps the results
  unnest() # puts it back in a dataframe and specify which columns to unnest
view(results) # views the results

# {Tidymodels} - pg 22, 23, & 24
linear_reg() # creates linear regression

lm_mod <- linear_reg() %>%
  set_engine("lm") # sets the engine for linear regression model
lm_mod

lm_mod <- linear_reg() %>%
  set_engine("lm") %>%
  fit(bill_length_mm ~ bill_depth_mm*species, data = penguins) # adds the model fit
lm_mod

lm_mod <- linear_reg() %>%
  set_engine("lm") %>%
  fit(bill_length_mm ~ bill_depth_mm*species, data = penguins) %>%
  tidy() # tidies model
lm_mod

# Pipe to a plot - 25
lm_mod <- linear_reg() %>%
  set_engine("lm") %>%
  fit(bill_length_mm ~ bill_depth_mm*species, data = penguins) %>%
  tidy() %>%
  ggplot() +
  geom_point(aes(x = term, y = estimate)) +
  geom_errorbar(aes(x = term, ymin = estimate-std.error,
                    ymax = estimate+std.error), width = 0.1 ) +
  coord_flip()
lm_mod

# Total awesome R package - pg 26 & 27
# pushover("Nyssa - your code is done.")
# pushover("Nyssa - the cats are awake and they are angry!!")