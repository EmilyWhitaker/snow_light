library(tidyverse)
library(lubridate)

bm_snow <- 
  bm_snow %>%
  separate(sampledate, c("year", "month"), sep= "-", extra = "merge")

glimpse(bm_snow)

bm_snow <-
  bm_snow %>%
  mutate(
    year = as.numeric(year)
  )
glimpse(bm_snow)

bm_snow <-
  bm_snow %>%
  mutate(
    yrs= cut(year,
             breaks =  c(-Inf, 1990, 2000, 2010, Inf),
             labels =  c("1980s", "1990s", "2000s", "2010s")
    )
  )

ggplot(data = bm_snow, mapping = aes(x = totice, y = avsnow)) + 
  geom_point(aes(color= year))+ 
  facet_wrap("yrs")

ggplot(data = bm_snow, mapping = aes(x = totice, y = avsnow)) + 
  geom_point(aes(color= whiteice))+ 
  facet_wrap("yrs")

ggplot(data = bm_snow, mapping = aes(x = avsnow, y = totice)) + 
  geom_point(aes(color= sampledate)) +
  theme_bw()

ggplot(data = bm_snow, mapping = aes(x = sampledate, y = totice)) + 
  geom_point(aes(color= avsnow))

ggplot(data = bm_snow, mapping = aes(x = sampledate, y = avsnow)) + 
  geom_point(aes(color= totice))+ 
  facet_wrap("white_ice")
