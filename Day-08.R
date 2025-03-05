# ESS 330 daily exercise 8
# Feb. 27, 2025
# Zoe Gagalis
url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties-recent.csv'
covid = read_csv(url)
library(tidyverse)
library(gapminder)
library(ggplot2)
library(dplyr)
covid <- read_csv('https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv')

dataframe <- data.frame(region = state.region,
                 abbr = state.abb,
                 state = state.name) 
inner_join(dataframe, covid, by = "state") |>
  group_by(region, date) |>
  summarize(cases = sum(cases),
            deaths = sum(deaths)) |>
  pivot_longer(cols = c(cases, deaths),
               names_to = "type",
               values_to = "count") |>
  ggplot(aes(x = date, y = count)) +
  geom_line() +
  facet_grid(type~region, scales = "free_y")+
  theme_dark()
