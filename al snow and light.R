library(tidyverse)
library(lubridate)

al_data <- 
  al_data %>%
  separate(sampledate, c("month", "day", "year"), sep= "/", extra = "merge")

glimpse(al_data)

al_data <-
  al_data %>%
  mutate(
    year = as.numeric(year)
  )
glimpse(al_data)

al_data <-
  al_data %>%
  mutate(
    yrs= cut(year,
             breaks =  c(-Inf, 10, 80, 90, Inf),
             labels =  c("2000s", "2010s", "1980s","1990s")
    )
  )

ggplot(data = al_data, mapping = aes(x = totice, y = avsnow)) + 
  geom_point(aes(color= light))+ 
  facet_wrap("yrs")

ggplot(data = al_data, mapping = aes(x = light, y = avsnow)) + 
  geom_point(aes(color= avsnow))+ 
  facet_wrap("yrs")

ggplot(data = al_data, mapping = aes(x = light, y = avsnow)) + 
  geom_point(aes(color= totice))+ 
  facet_wrap("yrs")
