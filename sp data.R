library(tidyverse)
library(lubridate)


sp_snowandlight<- 
  sp_snowandlight %>%
  separate(sampledate, c("month", "day", "year"), sep= "/", extra = "merge")

glimpse(sp_snowandlight)

sp_snowandlight <-
  sp_snowandlight %>%
  mutate(
    year = as.numeric(year)
  )
glimpse(sp_snowandlight)

sp_snowandlight <-
  sp_snowandlight %>%
  mutate(
    yrs= cut(year,
             breaks =  c(-Inf, 10, 80, 90, Inf),
             labels =  c("2000s", "2010s", "1980s","1990s")
    )
  )


ggplot(data = sp_snowandlight, mapping = aes(x = totice, y = avsnow)) + 
  geom_point(aes(color= extcoef))+ 
  facet_wrap("yrs")
