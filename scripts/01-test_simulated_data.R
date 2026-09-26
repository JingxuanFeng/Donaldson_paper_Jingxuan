#### Preamble ####
# Purpose: Tests the structure and validity of the simulated TTC data
# Author: Jingxuan Feng
# Date: 25 September 2026
# Contact: jingxuan.feng@mail.utoronto.ca
# License: MIT
# Pre-requisites: The 'tidyverse' package must be installed
# - 00-simulate_data.R must have been run


#### Workspace setup ####
library(tidyverse)

#keep time as text so the test can inspect the saved H:MM:SS format.
analysis_data <- read_csv(
  "data/00-simulated_data/simulated_TTC_subway_delays_data.csv",
  col_types = cols(time = col_character())
)

# Test if the data was successfully loaded
if (exists("analysis_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}


#### Test data ####

# Check if the dataset has 2000 rows
if (nrow(analysis_data) == 2000) {
  message("Test Passed: The dataset has 2000 rows.")
} else {
  stop("Test Failed: The dataset does not have 2000 rows.")
}

# Check if the dataset has 4 columns
if (ncol(analysis_data) == 4) {
  message("Test Passed: The dataset has 4 columns.")
} else {
  stop("Test Failed: The dataset does not have 4 columns.")
}



# Check if the 'line' column contains only valid TTC line codes.
valid_lines <- c("YU",
                 "BD",
                 "SHP")

if (all(analysis_data$line %in% valid_lines)) {
  message("Test Passed: The 'line' column contains only valid TTC lines.")
} else {
  stop("Test Failed: The 'line' column contains invalid TTC lines.")
}

# Check if the 'day' column contains only valid weekday names.
valid_days <- c("Monday",
                "Tuesday",
                "Wednesday",
                "Thursday",
                "Friday",
                "Saturday",
                "Sunday")

if (all(analysis_data$day %in% valid_days)) {
  message("Test Passed: The 'day' column contains only valid days.")
} else {
  stop("Test Failed: The 'day' column contains invalid days.")
}

# Check if there are any missing values in the dataset
if (all(!is.na(analysis_data))) {
  message("Test Passed: The dataset contains no missing values.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}

# Check if there are no empty strings in 'time', 'day', 'min_delay', and 'line' columns
if (all(analysis_data$time != "" & analysis_data$day != "" & analysis_data$min_delay != "" & analysis_data$line != "")) {
  message("Test Passed: There are no empty strings in 'time', 'day', 'min_delay', or 'line'.")
} else {
  stop("Test Failed: There are empty strings in one or more columns.")
}

# Check if the 'line' column has at least three unique values
if (n_distinct(analysis_data$line) >= 3) {
  message("Test Passed: The 'line' column contains at least three unique values.")
} else {
  stop("Test Failed: The 'line' column contains less than three unique values.")
}

#check the saved time format
valid_time_pattern <- "^([01]?[0-9]|2[0-3]):[0-5][0-9]:00$"

if (!anyNA(analysis_data$time) &&
    all(str_detect(analysis_data$time, valid_time_pattern))) {
  message("Test Passed: All times are valid H:MM:SS values with seconds equal to 00.")
} else {
  stop("Test Failed: Times must be nonmissing, between 0:00:00 and 23:59:00, with seconds equal to 00.")
}

#now check if the simulated delay times is non-negative
if (!any(analysis_data$min_delay < 0)) {
  message("Test Passed: The 'min_delay' columns all have non-negative values")
} else{
  stop("Test Failed: The 'min_delay' column contains negative values.")
}

