#### Preamble ####
# Purpose: Cleans the raw TTC subway delays in year 2024 data.
# Author: Jingxuan Feng
# Date: 25 September 2026
# Contact: jingxuan.feng@mail.utoronto.ca
# License: MIT
# Pre-requisites: The 'tidyverse' package must be installed


#### Workspace setup ####
library(tidyverse)

#### Clean data ####
raw_data <- read_csv("data/01-raw_data/ttc_subway_delays_2024_raw_data.csv")

cleaned_data <-
  raw_data |>
  janitor::clean_names() |>
  select(time, day, min_delay, line) |>
  mutate(
    min_delay = as.numeric(min_delay),
  ) |>
  tidyr::drop_na()

#### Save data ####
write_csv(cleaned_data, "data/02-analysis_data/ttc_subway_delays_2024_analysis_data.csv")

