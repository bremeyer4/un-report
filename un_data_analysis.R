library(tidyverse)

#loading data set with path specified (folder "Data")
gapminder_data <- read_csv("data/gapminder_data.csv")

gapminder_data <- read_csv("gapminder_data.csv")

summarize(gapminder_data, averagelifeExp = mean(lifeExp))

gapminder_data %>% summarize(averagelifeExp = mean(lifeExp))

gapminder_data %>%
  summarize(averagelifeExp = mean(lifeExp))

# %>%
# shift + control + m

gapminder_data_summarized <- gapminder_data %>% summarize(averagelifeExp = mean(lifeExp))

#danger!
gapminder_data <-  gapminder_data %>% summarize(averagelifeExp = mean(lifeExp))

gapminder_data %>% 
  summarize(recent_year = max(year))

gapminder_data %>% 
  filter(year == 2007) %>% 
  summarize(average = mean(lifeExp))

#Exercise 1 - average GDP by earliest year
gapminder_data %>% 
  filter(year == min(year)) %>% 
  summarize(average = mean(gdpPercap))

#group_by()
gapminder_data %>% 
  group_by(year) %>% 
  summarize(average = mean(lifeExp))

#Exercise 2 - average life expectancy by continent
gapminder_data %>% 
  group_by(continent) %>% 
  summarize(average = mean(lifeExp))

gapminder_data %>% 
  group_by(continent) %>% 
  summarize(average = mean(lifeExp), min = min(lifeExp))

#mutate()
gapminder_data %>% 
  mutate(gdp = pop * gdpPercap)

gapminder_data %>% 
  mutate(gdp = pop * gdpPercap, popInMillions = pop / 1000000)

#select()
gapminder_data %>% 
  select(pop, year)

gapminder_data %>% 
  select(-continent) 

gapminder_data %>% 
  select(year, starts_with('c'))

gapminder_data %>% 
  select(ends_with('p'))

?select

gapminder_data %>% 
  select(year, starts_with('con'))

#Exercise 3 - produce data frame with only columns country, continent, year, and life expectancy
gapminder_data %>% 
  select(-pop, -gdpPercap)