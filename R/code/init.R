#load in libraries
library(tidyverse)
library(dplyr)
library(readr)
library(readxl)
library(ggplot2)
library(stringr)
library(forcats)
library(lubridate)

#import data
orig_mens_data = read_csv("men_results.csv")
  #44,353 observations, 7 variables
orig_womens_data = read_csv("women_results.csv")
  #4,884 observations, 7 variables
glimpse(orig_mens_data)

#################################################################################################

#Filter the data as specified
filt_mens <- orig_mens_data %>%
  filter(tournament == "FIFA World Cup" & date > "2002-01-01")
  #384 observations, 8 variables
filt_womens <- orig_womens_data %>%
  filter(tournament == "FIFA World Cup" & date > "2002-01-01")
  #200 observations, 8 variables

#Need to create a new column indicating the total # goals scored in a match. This is the test value variable.
filt_mens <- filt_mens %>%
  mutate(num_goals = home_score + away_score)
filt_womens <- filt_womens %>%
  mutate(num_goals = home_score + away_score)
head(filt_mens)