#### Preamble ####
# Purpose: Tests cleaned data set to ensure accuracy.
# Author: Ricky Fung
# Date: 06 February 2024
# Contact: ricky.fung@mail.utoronto.ca
# Pre-requisites: Run scripts "01-download_data.R" and "02-data_cleaning.R".


#### Workspace setup ####
library(tidyverse)
cleaned_data <- read_csv("outputs/data/clean_pm_data.csv")

#### Test data ####

# Check if there are 31 Prime ministers (can be dupe)
cleaned_data$prime_minister %>% length() == 31

# Check if there are 31 birth years
cleaned_data$birth_year %>% length() == 31

# Check if there are 31 death years
cleaned_data$death_year %>% length() == 31

# Check if there are 31 years lived
cleaned_data$years_lived %>% length() == 31