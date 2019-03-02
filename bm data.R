library(tidyverse)
library(lubridate)


light_bm <- 
  light_bm %>%
  separate(sampledate, c("month", "day", "year"), sep= "/", extra = "merge")

glimpse(light_bm)

light_bm <-
  light_bm %>%
  mutate(
    year = as.numeric(year)
  )
glimpse(light_bm)

light_bm <-
  light_bm %>%
  mutate(
    yrs= cut(year,
             breaks =  c(-Inf, 10, 80, 90, Inf),
             labels =  c("2000s", "2010s", "1980s","1990s")
    )
  )


ggplot(data = light_bm, mapping = aes(x = totice, y = avsnow)) + 
  geom_point(aes(color= extcoef))+ 
  facet_wrap("yrs")
