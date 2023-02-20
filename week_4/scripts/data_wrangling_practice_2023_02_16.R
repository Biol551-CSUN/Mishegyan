### Today we are going to data wrangle provided chemical data####
### Created by: Avetis Mishegyan #############
### Updated on: 2023-02-16 ####################


#### Load Libraries ######
library(tidyverse)
library(here)
library(ggbernie)


### Load data ######
ChemData <- read_csv(here("week_4", "data", "chemicaldata_maunalua.csv"))
View(ChemData) # view opens a new window to view the data
glimpse(ChemData) # glimpse allows us to inspect the data


### Data Analysis ######
ChemData_clean <- ChemData %>%
  filter(complete.cases(.)) # filters out everything that is not a complete row (could also do drop_na())

View(ChemData_clean)

ChemData_clean<-ChemData %>%
  drop_na() %>% # filters out everything that is not a complete row
  separate(col = Tide_time, # choose the tide time col
           into = c("Tide", "Time"), # separate it into two columns Tide and time
           sep = "_" ) # separate by _

head(ChemData_clean)

ChemData_clean<-ChemData %>%
  drop_na() %>%
  separate(col = Tide_time,
           into = c("Tide", "Time"),
           sep = "_",
           remove = FALSE) # keeps the original tide_time column

head(ChemData_clean)

ChemData_clean<-ChemData %>%
  drop_na() %>%
  separate(col = Tide_time,
           into = c("Tide", "Time"),
           sep = "_",
           remove = FALSE) %>%
  unite(col = "Site_Zone", # the name of the new column
         c(Site, Zone), # the columns to unite
        sep = ".", # lets put a . in the middle
        remove = FALSE) # keep the original

head(ChemData_clean)

ChemData_long <-ChemData_clean %>%
  pivot_longer(cols = Temp_in:percent_sgd, # the cols you want to pivot. This says select the temp to percent SGD columns
               names_to = "Variables", # the names of the new columns with all the column names
               values_to = "Values") # names of the new column with all the values

View(ChemData_long)

ChemData_long %>%
  group_by(Variables, Site) %>% # group by everything we want
  summarise(Param_means = mean(Values, na.rm = TRUE), # get mean
            Param_vars = var(Values, na.rm = TRUE)) # get variance
## summarise() has grouped output by 'Variables'. You can override using the
## .groups argument.

ChemData_long %>% # question 1 - slide 21
  group_by(Variables, Site, Zone, Tide) %>%
  summarise(Param_means = mean(Values, na.rm = TRUE),
            Param_vars = var(Values, na.rm = TRUE),
            Param_sd = sd(Values, na.rm = TRUE))

ChemData_long %>%
  ggplot(aes(x = Site, 
             y = Values)) +
  geom_boxplot()+
  facet_wrap(~Variables)

ChemData_long %>%
  ggplot(aes(x = Site, 
             y = Values)) +
  geom_boxplot()+
  facet_wrap(~Variables) +
  facet_wrap(~Variables, scales = "free")

ChemData_wide <- ChemData_long %>%
  pivot_wider(names_from = Variables, # column with the names for the new columns
              values_from = Values) # column with the values

View(ChemData_wide)

# Start from the beginning and work through our entire flow again, ending with data export.
ChemData_clean<-ChemData %>%
  drop_na()  #filters out everything that is not a complete row

View(ChemData_clean)

ChemData_clean<-ChemData %>%
  drop_na() %>% #filters out everything that is not a complete row
  separate(col = Tide_time, # choose the tide time col
           into = c("Tide","Time"), # separate it into two columns Tide and time
           sep = "_", # separate by _
           remove = FALSE)

View(ChemData_clean)

ChemData_clean<-ChemData %>%
  drop_na() %>% #filters out everything that is not a complete row
  separate(col = Tide_time, # choose the tide time col
           into = c("Tide","Time"), # separate it into two columns Tide and time
           sep = "_", # separate by _
           remove = FALSE)

View(ChemData_clean)

ChemData_clean<-ChemData %>%
  drop_na() %>% #filters out everything that is not a complete row
  separate(col = Tide_time, # choose the tide time col
           into = c("Tide","Time"), # separate it into two columns Tide and time
           sep = "_", # separate by _
           remove = FALSE) %>%
  pivot_longer(cols = Temp_in:percent_sgd, # the cols you want to pivot. This says select the temp to percent SGD cols
               names_to = "Variables", # the names of the new cols with all the column names
               values_to = "Values") # names of the new column with all the values

View(ChemData_clean)

ChemData_clean<-ChemData %>%
  drop_na() %>% #filters out everything that is not a complete row
  separate(col = Tide_time, # choose the tide time col
           into = c("Tide","Time"), # separate it into two columns Tide and time
           sep = "_", # separate by _
           remove = FALSE) %>%
  pivot_longer(cols = Temp_in:percent_sgd, # the cols you want to pivot. This says select the temp to percent SGD cols  
               names_to = "Variables", # the names of the new cols with all the column names 
               values_to = "Values") %>% # names of the new column with all the values 
  group_by(Variables, Site, Time) %>%
  summarise(mean_vals = mean(Values, na.rm = TRUE))

View(ChemData_clean)

ChemData_clean<-ChemData %>%
  drop_na() %>% #filters out everything that is not a complete row
  separate(col = Tide_time, # choose the tide time col
           into = c("Tide","Time"), # separate it into two columns Tide and time
           sep = "_", # separate by _
           remove = FALSE) %>%
  pivot_longer(cols = Temp_in:percent_sgd, # the cols you want to pivot. This says select the temp to percent SGD cols  
               names_to = "Variables", # the names of the new cols with all the column names 
               values_to = "Values") %>% # names of the new column with all the values 
  group_by(Variables, Site, Time) %>% 
  summarise(mean_vals = mean(Values, na.rm = TRUE)) %>%
  pivot_wider(names_from = Variables,
              values_from = mean_vals) # notice it is now mean_vals as the col name

View(ChemData_clean)

ChemData_clean<-ChemData %>%
  drop_na() %>% #filters out everything that is not a complete row
  separate(col = Tide_time, # choose the tide time col
           into = c("Tide","Time"), # separate it into two columns Tide and time
           sep = "_", # separate by _
           remove = FALSE) %>%
  pivot_longer(cols = Temp_in:percent_sgd, # the cols you want to pivot. This says select the temp to percent SGD cols  
               names_to = "Variables", # the names of the new cols with all the column names 
               values_to = "Values") %>% # names of the new column with all the values 
  group_by(Variables, Site, Time) %>% 
  summarise(mean_vals = mean(Values, na.rm = TRUE)) %>%
  pivot_wider(names_from = Variables, 
              values_from = mean_vals) %>% # notice it is now mean_vals as the col name
  write_csv(here("week_4","output","summary.csv"))  # export as a csv to the right folder
## summarise() has grouped output by 'Variables', 'Site'. You can override using
## the .groups argument.

ggplot(ChemData) +
  geom_bernie(aes(x = Salinity, y = NN), bernie = "sitting")
