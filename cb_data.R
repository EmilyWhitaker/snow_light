library(tidyverse)
library(lubridate)


cb_data <- 
  cb_data %>%
  separate(sampledate, c("month", "day", "year"), sep= "/", extra = "merge")

glimpse(cb_data)

cb_data <-
  cb_data %>%
  mutate(
    year = as.numeric(year)
  )
glimpse(cb_data)

cb_data <-
  cb_data %>%
  mutate(
    yrs= cut(year,
             breaks =  c(-Inf, 10, 80, 90, Inf),
             labels =  c("2000s", "2010s", "1980s","1990s")
    )
  )


ggplot(data = cb_data, mapping = aes(x = totice, y = avsnow)) + 
  geom_point(aes(color= extcoef))+ 
  facet_wrap("yrs")
