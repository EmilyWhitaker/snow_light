library(tidyverse)
library(lubridate)


cr_snowandlight<- 
  cr_snowandlight %>%
  separate(sampledate, c("month", "day", "year"), sep= "/", extra = "merge")

glimpse(cr_snowandlight)

cr_snowandlight <-
  cr_snowandlight %>%
  mutate(
    year = as.numeric(year)
  )
glimpse(cr_snowandlight)

cr_snowandlight <-
  cr_snowandlight %>%
  mutate(
    yrs= cut(year,
             breaks =  c(-Inf, 10, 80, 90, Inf),
             labels =  c("2000s", "2010s", "1980s","1990s")
    )
  )


ggplot(data = cr_snowandlight, mapping = aes(x = totice, y = avsnow)) + 
  geom_point(aes(color= extcoef))+ 
  facet_wrap("yrs")
