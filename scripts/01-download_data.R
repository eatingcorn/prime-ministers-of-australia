#### Preamble ####
# Purpose: Read and save HTML from wikipedia list of Australian prime ministers.
# Author: Ricky Fung
# Date: 06 February 2024
# Contact: ricky.fung@mail.utoronto.ca
# Pre-requisites: Install tidyverse, xml12, and rvest package.


#### Workspace setup ####
library(tidyverse)
library(xml2)
library(rvest)

#### Read Data ####
raw_data <- read_html("https://en.wikipedia.org/wiki/List_of_prime_ministers_of_Australia")


#### Save Data ####
write_html(raw_data, "inputs/data/pms.html")


         
