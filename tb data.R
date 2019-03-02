library(tidyverse)
library(lubridate)


tb_snowlight<- 
  tb_snowlight %>%
  separate(sampledate, c("month", "day", "year"), sep= "/", extra = "merge")

glimpse(tb_snowlight)

tb_snowlight <-
  tb_snowlight %>%
  mutate(
    year = as.numeric(year)
  )
glimpse(tb_snowlight)

tb_snowlight <-
  tb_snowlight %>%
  mutate(
    yrs= cut(year,
             breaks =  c(-Inf, 10, 80, 90, Inf),
             labels =  c("2000s", "2010s", "1980s","1990s")
    )
  )


ggplot(data = tb_snowlight, mapping = aes(x = totice, y = avsnow)) + 
  geom_point(aes(color= extcoef))+ 
  facet_wrap("yrs")
