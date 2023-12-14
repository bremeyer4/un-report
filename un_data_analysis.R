library(tidyverse)

#loading data set with path specified (folder "Data")
gapminder_data <- read_csv("data/gapminder_data.csv")

#loading data normally
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

#Wide format
gapminder_data %>% 
  select(country, continent, year, lifeExp) %>% 
  pivot_wider(names_from = year, values_from = lifeExp)

#new data set
gapminder_data_2007 <- read_csv("gapminder_data.csv") %>% 
  filter(year == 2007 & continent == "Americas") %>% 
  select(-year, -continent)

temp <- read_csv("co2-un-data.csv")

read_csv("co2-un-data.csv", skip = 1) #skips unnecessary first row

#loading and naming uncleaned data
co2_emissions_dirty <- read_csv("co2-un-data.csv", skip = 2,
                                col_names = c("region", "country", 
                                              "year", "series", "value",
                                              "footnotes", "source"))
co2_emissions_dirty

read_csv("co2-un-data.csv", skip = 1) %>% 
  rename(Country = ...2) #another way to rename columns

co2_emissions_dirty %>% 
  select(country, year, series, value)

#recode() to change values
co2_emissions_dirty %>% 
  select(country, year, series, value) %>% 
  mutate(series = recode(series, "Emissions (thousand metric tons of carbon dioxide)" = "total_emissions", 
                         "Emissions per capita (metric tons of carbon dioxide)" = "per_capita_emissions"))

co2_emissions_dirty %>% 
  select(country, year, series, value) %>% 
  mutate(series = recode(series, "Emissions (thousand metric tons of carbon dioxide)" = "total_emissions", 
                         "Emissions per capita (metric tons of carbon dioxide)" = "per_capita_emissions")) %>% 
  pivot_wider(names_from = series, values_from = value)

co2_emissions_dirty %>% 
  select(country, year, series, value) %>% 
  mutate(series = recode(series, "Emissions (thousand metric tons of carbon dioxide)" = "total_emissions", 
                         "Emissions per capita (metric tons of carbon dioxide)" = "per_capita_emissions")) %>% 
  pivot_wider(names_from = series, values_from = value) %>% 
  count(year)

#Exercise 4 - filter out data for 2005 and remove year column
co2_emissions_dirty %>% 
  select(country, year, series, value) %>% 
  mutate(series = recode(series, "Emissions (thousand metric tons of carbon dioxide)" = "total_emissions", 
                         "Emissions per capita (metric tons of carbon dioxide)" = "per_capita_emissions")) %>% 
  pivot_wider(names_from = series, values_from = value) %>% 
  filter(year == 2005) %>% 
  select(-year)

#saving cleaned data
co2_emissions <- co2_emissions_dirty %>% 
  select(country, year, series, value) %>% 
  mutate(series = recode(series, "Emissions (thousand metric tons of carbon dioxide)" = "total_emissions", 
                         "Emissions per capita (metric tons of carbon dioxide)" = "per_capita_emissions")) %>% 
  pivot_wider(names_from = series, values_from = value) %>% 
  filter(year == 2005) %>% 
  select(-year)

#merging two data sets
inner_join(gapminder_data, co2_emissions)

inner_join(gapminder_data, co2_emissions, by = "country")

gapminder_co2 <- inner_join(gapminder_data_2007, co2_emissions, by = "country")

#plotting data
ggplot(gapminder_co2, aes(x = gdpPercap, y = per_capita_emissions)) + 
  geom_point() +
  labs(x = "GDP (per capita)", y = "CO2 emitted (per capita)", 
       title = "Strong association between a nation's GDP and CO2 production")
