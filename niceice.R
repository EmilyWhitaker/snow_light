library(tidyverse)
library(lubridate)

sp_ice <-
  sp_ice %>%
  mutate(
    dpth= cut(depth,
             breaks =  c(-Inf, 3, 8, Inf),
             labels =  c("epi", "meta", "hypo") 
    )
  )


#sp_ice <- 
#  sp_ice %>%
#  separate(sampledate, c("month", "day", "year"), sep= "/", extra = "merge")

glimpse(sp_ice)

ggplot(data = sp_ice, mapping = aes(x = avsnow, y = extcoef)) + 
  geom_point(aes(color= dpth))



  facet_wrap("dpth")


  



