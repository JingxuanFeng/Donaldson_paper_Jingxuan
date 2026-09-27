# TTC_Subway_Delay_Patterns

## Overview

This repository examines 2024 TTC subway delay records from Toronto Open Data, comparing the Yonge–University, Bloor–Danforth, and Sheppard lines during morning peaks, evening peaks, and other times. The analysis considers both the proportion of records with positive delays and the median duration of those positive delays.


## File Structure

The repo is structured as:

-   `data/01-raw_data` contains the raw data as obtained from TTC subway delay times, 2024, Toronto Open Data.
-   `data/02-analysis_data` contains the cleaned dataset that was constructed.
-   `data/03-simulated_data` contains the simulated dataset.
-   `other` contains details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.


## Statement on LLM usage
Statement on LLM usage: I used RStudio’s autocomplete tool while writing code. I also used ChatGPT to help me understand the assignment and example code, debug code that I wrote, and refine text that I had drafted. The entire chat history is available in other/llm_usage.txt.
