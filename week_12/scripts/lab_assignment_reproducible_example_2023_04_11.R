library(tidyverse)
library(ggthemes)
library(palmerpenguins)
library(here)
#> here() starts at /private/var/folders/qd/pfhjpjg575x0_3hmmf6cz_c80000gn/T/RtmpB8ACsf/reprex-5e80179ec541-hurt-puma


tibble::tribble(
  ~species,     ~island, ~bill_length_mm, ~bill_depth_mm, ~flipper_length_mm, ~body_mass_g,     ~sex, ~year,
  "Adelie", "Torgersen",            39.1,           18.7,               181L,        3750L,   "male", 2007L,
  "Adelie", "Torgersen",            39.5,           17.4,               186L,        3800L, "female", 2007L,
  "Adelie", "Torgersen",            40.3,             18,               195L,        3250L, "female", 2007L,
  "Adelie", "Torgersen",              NA,             NA,                 NA,           NA,       NA, 2007L,
  "Adelie", "Torgersen",            36.7,           19.3,               193L,        3450L, "female", 2007L,
  "Adelie", "Torgersen",            39.3,           20.6,               190L,        3650L,   "male", 2007L,
  "Adelie", "Torgersen",            38.9,           17.8,               181L,        3625L, "female", 2007L,
  "Adelie", "Torgersen",            39.2,           19.6,               195L,        4675L,   "male", 2007L,
  "Adelie", "Torgersen",            34.1,           18.1,               193L,        3475L,       NA, 2007L,
  "Adelie", "Torgersen",              42,           20.2,               190L,        4250L,       NA, 2007L,
  "Adelie", "Torgersen",            37.8,           17.1,               186L,        3300L,       NA, 2007L,
  "Adelie", "Torgersen",            37.8,           17.3,               180L,        3700L,       NA, 2007L,
  "Adelie", "Torgersen",            41.1,           17.6,               182L,        3200L, "female", 2007L,
  "Adelie", "Torgersen",            38.6,           21.2,               191L,        3800L,   "male", 2007L,
  "Adelie", "Torgersen",            34.6,           21.1,               198L,        4400L,   "male", 2007L,
  "Adelie", "Torgersen",            36.6,           17.8,               185L,        3700L, "female", 2007L,
  "Adelie", "Torgersen",            38.7,             19,               195L,        3450L, "female", 2007L,
  "Adelie", "Torgersen",            42.5,           20.7,               197L,        4500L,   "male", 2007L,
  "Adelie", "Torgersen",            34.4,           18.4,               184L,        3325L, "female", 2007L,
  "Adelie", "Torgersen",              46,           21.5,               194L,        4200L,   "male", 2007L
)
#> # A tibble: 20 × 8
#>    species island    bill_length_mm bill_depth_mm flipper_…¹ body_…² sex    year
#>    <chr>   <chr>              <dbl>         <dbl>      <int>   <int> <chr> <int>
#>  1 Adelie  Torgersen           39.1          18.7        181    3750 male   2007
#>  2 Adelie  Torgersen           39.5          17.4        186    3800 fema…  2007
#>  3 Adelie  Torgersen           40.3          18          195    3250 fema…  2007
#>  4 Adelie  Torgersen           NA            NA           NA      NA <NA>   2007
#>  5 Adelie  Torgersen           36.7          19.3        193    3450 fema…  2007
#>  6 Adelie  Torgersen           39.3          20.6        190    3650 male   2007
#>  7 Adelie  Torgersen           38.9          17.8        181    3625 fema…  2007
#>  8 Adelie  Torgersen           39.2          19.6        195    4675 male   2007
#>  9 Adelie  Torgersen           34.1          18.1        193    3475 <NA>   2007
#> 10 Adelie  Torgersen           42            20.2        190    4250 <NA>   2007
#> 11 Adelie  Torgersen           37.8          17.1        186    3300 <NA>   2007
#> 12 Adelie  Torgersen           37.8          17.3        180    3700 <NA>   2007
#> 13 Adelie  Torgersen           41.1          17.6        182    3200 fema…  2007
#> 14 Adelie  Torgersen           38.6          21.2        191    3800 male   2007
#> 15 Adelie  Torgersen           34.6          21.1        198    4400 male   2007
#> 16 Adelie  Torgersen           36.6          17.8        185    3700 fema…  2007
#> 17 Adelie  Torgersen           38.7          19          195    3450 fema…  2007
#> 18 Adelie  Torgersen           42.5          20.7        197    4500 male   2007
#> 19 Adelie  Torgersen           34.4          18.4        184    3325 fema…  2007
#> 20 Adelie  Torgersen           46            21.5        194    4200 male   2007
#> # … with abbreviated variable names ¹​flipper_length_mm, ²​body_mass_g


torgersen_penguins <- penguins %>%
  filter(island == "Torgersen")

plot1 <- ggplot(data=torgersen_penguins,
                aes(x = bill_depth_mm, y = bill_length_mm, group = species, color = species)) + # missing aes() around arguments
  geom_point()+ 
  labs(x = "Bill depth (mm)", 
       y = "Bill length (mm)"
  ) +
  theme_economist() +
  theme(axis.title = element_text(size = 20),
        panel.background = element_rect(fill = "beige", color = "blue"))
plot1 # missing plot name, you need to run it to print the plot