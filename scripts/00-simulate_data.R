#### Preamble ####
# Purpose: Simulates a dataset of TTC subway delay times
# Author: Jingxuan Feng
# Date: 25 September 2026
# Contact: jingxuan.feng@mail.utoronto.ca
# License: MIT
# Pre-requisites: The 'tidyverse' package must be installed


#### Workspace setup ####
library(tidyverse)
set.seed(853)


#### Simulate data ####
# TTC line names
lines <- c(
  "YU",
  "BD",
  "SHP"
)


#then simulate time ranging from 00:00:00 to 23:59:00 (with seconds fixed at 00), keeping the same format as analysis_data
n <- 2000
minute <- sample(0:1439, size = n, replace = TRUE)

simulated_time <- sprintf("%d:%02d:00", minute %/% 60, minute %% 60)
simulated_time <- hms::parse_hms(simulated_time)

#then simulate days
days <- c(
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday"
)

simulated_delay <- sample(0:30, size = n, replace = TRUE)


# Create a simulated dataset
analysis_data <- tibble(
  time = simulated_time,
  day = sample(
    days,
    size = n,
    replace = TRUE,
    prob = c(0.16, 0.14, 0.14, 0.14, 0.14, 0.14, 0.14)
  ),
  min_delay = simulated_delay,
  line = sample(
    lines,
    size = n,
    replace = TRUE,
    prob = c(0.50, 0.40, 0.1) # Rough TTC line distribution
  )
)


#### Save data ####
write_csv(analysis_data, "data/00-simulated_data/simulated_TTC_subway_delays_data.csv")

