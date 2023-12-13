#loading tidyverse
library(tidyverse)

#loading and naming gapminder_1997 data set
gapminder_1997 <- read_csv("gapminder_1997.csv")

View(gapminder_1997)

#learning how to name
name <- "Ben"
name

age <- 26
age

name <- "Harry Potter"

test <- read_csv("gapminder_1997.csv")

#testing functions
Sys.Date() # outputs the current data, used for knowing when I last ran

getwd() # outputs current directory

sum(5,6) # adds numbers

round(3.1415,2)

read_csv(file = 'gapminder_1997.csv')

#original ggplot code
ggplot(data=gapminder_1997) + 
  aes(x = gdpPercap) +
  labs(x = "GDP Per Capita") +
  aes(y = lifeExp) +
  labs(y = "Life Expectancy") +
  geom_point() +
  labs(title = "Do people in wealthy countries live longer?") +
  aes(color = continent) +
  scale_color_brewer(palette = "Set1") +
  aes(size = pop/1000000) +
  labs(size = "Population (in millions)") +
  aes(shape = continent)

#simplified code with less lines
ggplot(data = gapminder_1997) +
  aes(x = gdpPercap, y = lifeExp, color = continent, 
      size = pop/1000000, shape = continent) +
  geom_point() +
  scale_color_brewer(palette = "Set1") +
  labs(x = "GDP Per Capita", y = "Life Expectancy", 
       title = "Do people in wealthy countries live longer?", 
       size = "Population (in millions)")

#loading new dataset
gapminder_data <- read_csv("gapminder_data.csv")

#exploring the data
dim(gapminder_data) #explores the dimensions of the data

head(gapminder_data) #returns the first few rows of the data set

#ggplot of new data
ggplot(data = gapminder_data) +
  aes(x = year, y = lifeExp, color = continent) +
  geom_point() +
  scale_color_brewer(palette = "Set1") +
  labs( x ="Year", y = "Life Expectancy")
