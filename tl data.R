library(tidyverse)
library(lubridate)


tl_snowandice<- 
  tl_snowandice %>%
  separate(sampledate, c("month", "day", "year"), sep= "/", extra = "merge")

glimpse(tl_snowandice)

tl_snowandice <-
  tl_snowandice %>%
  mutate(
    year = as.numeric(year)
  )
glimpse(tl_snowandice)

tl_snowandice <-
  tl_snowandice %>%
  mutate(
    yrs= cut(year,
             breaks =  c(-Inf, 10, 80, 90, Inf),
             labels =  c("2000s", "2010s", "1980s","1990s")
    )
  )


ggplot(data = tl_snowandice, mapping = aes(x = totice, y = avsnow)) + 
  geom_point(aes(color= extcoef))+ 
  facet_wrap("yrs")
