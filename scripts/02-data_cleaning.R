#### Preamble ####
# Purpose: Web scraping and cleaning of Wikepdia page
# Author: Ricky Fung
# Date: 06 February 2024
# Contact: ricky.fung@mail.utoronto.ca
# Pre-requisites: Run script "01-download_data.R" and install janitor package.

#### Workspace setup ####
library(tidyverse)
library(janitor)

#### Reading Data ####
raw_data <- read_html("inputs/data/pms.html")

#### Parsing ####
parse_data_selector_gadget <-
  raw_data |>
  html_element(".wikitable") |>
  html_table()

parsed_data <-
  parse_data_selector_gadget |> 
  clean_names() |> 
  rename(raw_text = name_birth_death_constituency) |> 
  select(raw_text) |> 
  filter(raw_text != "Prime ministerOffice(Lifespan)") |> 
  distinct()

#### Cleaning ####

initial_clean <- parsed_data %>%
  separate(
    raw_text, into = c("name", "not_name"), sep = "\\(", extra="merge",
  ) %>%
  mutate(
    date = str_extract(not_name, "[[:digit:]]{4}(?:–[[:digit:]]{4})?"),
    born = str_extract(not_name, "born[[:space:]][[:digit:]]{4}")
  ) %>%
  select(name, date, born)
#remove first row
initial_clean <- initial_clean[-1, ]

cleaned_data <-
  initial_clean |>
  separate(date, into = c("birth", "died"), 
           sep = "–") |>   # PMs who have died have their birth and death years 
  # separated by a hyphen, but we need to be careful with the hyphen as it seems 
  # to be a slightly odd type of hyphen and we need to copy/paste it.
  mutate(
    born = str_remove_all(born, "born[[:space:]]"),
    birth = if_else(!is.na(born), born, birth)
  ) |> # Alive PMs have slightly different format
  select(-born) |>
  rename(prime_minister = name, birth_year = birth, death_year = died) |> 
  mutate(across(c(birth_year, death_year), as.integer)) |> 
  mutate(years_lived = death_year - birth_year) |> 
  distinct() # Some of the PMs had two goes at it.

write_csv(cleaned_data, "outputs/data/clean_pm_data.csv")

