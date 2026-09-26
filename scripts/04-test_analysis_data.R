#### Preamble ####
# Purpose: Tests.structure and validity of the cleaned TTC data
# Author: Jingxuan Feng
# Date: 25 September 2026
# Contact: jingxuan.feng@mail.utoronto.ca
# License: MIT
# Pre-requisites: The 'tidyverse' and 'testthat' package must be installed
# - 00-simulate_data.R must have been run


#### Workspace setup ####
library(tidyverse)
library(testthat)

analysis_data <- read_csv(
  here::here(
    "data",
    "02-analysis_data",
    "ttc_subway_delays_2024_analysis_data.csv"))


#### Test data ####
# Test that the dataset has 4 columns
test_that("dataset has 4 columns", {
  expect_equal(ncol(analysis_data), 4)
})

# Test that the 'time' column is time type
test_that("'time' is time-of-day value", {
  expect_s3_class(analysis_data$time, "hms")
})

# Test that the 'day' column is character type
test_that("'day' is character", {
  expect_type(analysis_data$day, "character")
})

# Test that the 'line' column is character type
test_that("'line' is character", {
  expect_type(analysis_data$line, "character")
})

# Test that there are no missing values in the dataset
test_that("no missing values in dataset", {
  expect_true(all(!is.na(analysis_data)))
})


# Test that 'line' contains only valid TTC line names
valid_lines <- c("YU", "BD", "SHP")
test_that("'line' contains valid TTC line names", {
  expect_true(all(analysis_data$line %in% valid_lines))
})

# Test that 'day' contains only valid day
valid_days <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
test_that("'day' contains valid days", {
  expect_true(all(analysis_data$day %in% valid_days))
})

# Test that there are no empty strings in 'time', 'day', 'min_delay', or 'line' columns
test_that("no empty strings in 'time', 'day', or 'min_delay' and 'line' columns", {
  expect_false(any(analysis_data$time == "" | analysis_data$day == "" | analysis_data$min_delay == "" | analysis_data$line == ""))
})

# Test that the 'line' column contains at least 3 unique values
test_that("'line' column contains at least 3 unique values", {
  expect_true(length(unique(analysis_data$line)) >= 3)
})