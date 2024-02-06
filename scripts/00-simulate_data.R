#### Preamble ####
# Purpose: Simulates data for Prime Minister lifespans for Australia
# to facilitate testing.
# Author: Ricky Fung
# Date: 06 February 2024
# Contact: ricky.fung@mail.utoronto.ca
# Pre-requisites: Install tidyverse and babynames package.

#### Workspace setup ####
library(tidyverse)
library(babynames)

#### Simulate data ####
set.seed(302)

simulated_dataset <-
  tibble(
    prime_minister = babynames |>
      filter(prop > 0.01) |>
      distinct(name) |>
      unlist() |>
      sample(size = 31, replace = FALSE),
    birth_year = sample(1845:1968, size = 31, replace = TRUE),
    years_lived = sample(50:100, size = 31, replace = TRUE),
    death_year = birth_year + years_lived
  ) |>
  select(prime_minister, birth_year, death_year, years_lived) |>
  arrange(birth_year)


#### Tests ####

# Check if there are 31 Prime ministers (can be dupe)
simulated_dataset$prime_minister %>% length() == 31

# Check if there are 31 birth years
simulated_dataset$birth_year %>% length() == 31

# Check if there are 31 death years
simulated_dataset$death_year %>% length() == 31

# Check if there are 31 years lived
simulated_dataset$years_lived %>% length() == 31