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
TTC_lines <- c(
  "YU",
  "BD",
  "SHP"
)


#then simulate time ranging from 00:00:00 to 24:00:00 (with seconds fixed at 00), keeping the same format as analysis_data
n <- 2000
minute <- sample(0:1439, size = n, replace = TRUE)

simulated_time <- sprintf("%d:%02d:00", minute %/% 60, minute %% 60)

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


# Create a dataset by randomly assigning TTC lines and simulated time to id number
analysis_data <- tibble(
  id = seq_len(n),
  time = simulated_time,
  day = sample(
    days,
    size = n,
    replace = TRUE,
    prob = c(0.16, 0.14, 0.14, 0.14, 0.14, 0.14, 0.14)
  ),
  TTC_line = sample(
    TTC_lines,
    size = n,
    replace = TRUE,
    prob = c(0.50, 0.40, 0.1) # Rough TTC line distribution
  )
)


#### Save data ####
write_csv(analysis_data, "data/00-simulated_data/simulated_TTC_subway_delays_data.csv")

