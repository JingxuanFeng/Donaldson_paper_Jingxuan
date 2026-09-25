#### Preamble ####
# Purpose: Downloads and saves the data from opendatatoronto: TTC subway delay data - 2024
# Author: Jingxuan Feng
# Date: 25 September 2026
# Contact: jingxuan.feng@mail.utoronto.ca
# License: MIT
# Pre-requisites: The 'tidyverse' and 'opendatatoronto' package must be installed


#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)

#### Download data ####
# first find the TTC subway delay data
resources <- list_package_resources("https://open.toronto.ca/dataset/ttc-subway-delay-data/")
#then get the specific dataset: 2024 TTC subway delay data
resource_2024 <- resources |>
  filter(name == "ttc-subway-delay-data-2024")

raw_data <- get_resource(resource_2024)


#### Save data ####
write_csv(raw_data, "data/01-raw_data/ttc_subway_delays_2024_raw_data.csv") 

         
