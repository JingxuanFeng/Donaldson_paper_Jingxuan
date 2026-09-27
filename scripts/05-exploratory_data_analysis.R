#### Preamble ####
# Purpose: Visualize data points using graphs and tables
# Author: Jingxuan Feng
# Date: 25 September 2026
# Contact: jingxuan.feng@mail.utoronto.ca
# License: MIT
# Pre-requisites: The 'tidyverse' and 'tinytable' package must be installed
## - 02-download_data.R, 03-clean_data.R  and 04-test_analysis_data.R must have been run


#### Workspace setup ####
library(tidyverse)
library(tinytable)

#### Read data ####
analysis_data <- read_csv("data/02-analysis_data/ttc_subway_delays_2024_analysis_data.csv")

ggplot(analysis_data, aes(line, min_delay, colour = line)) +
  geom_jitter(width = 0.15, height = 0, alpha = 0.7, size = 1.0) +
  scale_x_discrete(labels = c(
    BD = "Line 2: Bloor–Danforth",
    SHP = "Line 4: Sheppard",
    YU = "Line 1: Yonge–University"
  )) +
  labs(
    title = "TTC subway delay records, 2024",
    x = NULL, y = "Recorded delay (minutes)",
  ) +
  theme_minimal() +
  theme(legend.position = "none")


#divide the data into three time period: morning peak (6am - 9am) in weekdays, 
#evening peak (3pm - 7pm) in weekdays, and other times
plot_data <- analysis_data |>
  mutate(
    hour = as.numeric(time) / 3600,
    weekday = day %in% c("Monday", "Tuesday", "Wednesday",
                         "Thursday", "Friday"),
    period = case_when(
      weekday & hour >= 6 & hour < 9 ~ "Morning peak",
      weekday & hour >= 15 & hour < 19 ~ "Evening peak",
      TRUE ~ "Other times"
    ),
    period = factor(period, levels = c(
      "Morning peak", "Evening peak", "Other times"
    ))
  )

median_table <- plot_data |>
  filter(min_delay > 0) |>
  group_by(line, period) |>
  summarise(median_delay = median(min_delay), .groups = "drop") |>
  pivot_wider(names_from = period, values_from = median_delay) |>
  arrange(factor(line, levels = c("YU", "BD", "SHP"))) |>
  select(
    Line = line,
    `Morning peak delay (min)` = `Morning peak`,
    `Evening peak delay (min)` = `Evening peak`,
    `Other times delay (min)` = `Other times`
  )

tt(median_table)


zero_table <- plot_data |>
  group_by(line, period) |>
  summarise(
    zero_percent = sprintf("%.1f%%", mean(min_delay == 0) * 100),
    .groups = "drop"
  ) |>
  pivot_wider(names_from = period, values_from = zero_percent) |>
  arrange(factor(line, levels = c("YU", "BD", "SHP"))) |>
  select(
    Line = line,
    `Morning peak delay (%)` = `Morning peak`,
    `Evening peak delay (%)` = `Evening peak`,
    `Other times delay (%)` = `Other times`
  )

tinytable::tt(zero_table)

analysis_data |>
  filter(min_delay > 0) |>
  ggplot(aes(min_delay)) +
  geom_histogram(
    binwidth = 5, boundary = 0, closed = "left",
    fill = "#377C9E", colour = "red"
  ) +
  facet_wrap(~line, labeller = as_labeller(c(
    YU = "Line 1: Yonge–University",
    BD = "Line 2: Bloor–Danforth",
    SHP = "Line 4: Sheppard"
  ))) +
  labs(x = "Positive recorded delay (minutes)", y = "Number of records") +
  theme_minimal()

