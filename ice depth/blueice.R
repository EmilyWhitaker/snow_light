library(lubridate)
library(ggplot2)
library(ggridges)
library(tidyverse)

lightatdeck <-
  lightatdeck %>% 
  filter(depth == 0)


#join the blue ice col from blu2 to allsnowandlight?


typeof(lightatdeck$sampledate)
typeof(bu2$sampledate)

bu2$sampledate <- format(bu2$sampledate, "%m/%d/%Y")

blu2_date <-
  bu2 %>%
  mutate(
    sampledate= as.Date(sampledate)
    )

typeof(blu2_date$sampledate)

bluwhiteice$newdate <- strptime(as.character(bluwhiteice$sampledate), "%Y-%m-%d")
bluwhiteice$newdate <-format(bluwhiteice$newdate, "%m/%d/%Y")

blue

blu2 %>%
  map_df(~ .x %>% 
           mutate_if(is.numeric, as.character))



lte_2 = lightatdeck %>% 
  right_join(blu2,by = c('sampledate', 'lakeid'))

lte2$adjustedlight <-lte2[, 5]/lte2[,4]


ggplot(data = lte_2, mapping = aes(x = avsnow, y = light)) +
  geom_point(aes(color= lakeid)) +
  labs(y = 'light at 0m ',x = 'snow (cm)')


ggplot(data = lte, mapping = aes(x = whiteice, y = light)) +
  geom_point(aes(color= lakeid)) +
  labs(y = 'light at 0m ',x = 'white ice (cm)')

ggplot(data = lte, mapping = aes(x = avsnow, y = adjustedlight)) +
  geom_point(aes(color= lakeid)) +
  labs(y = 'light at 0m ',x = 'snow (cm)')

fit= lm(light ~ avsnow + totice+ , data= lte2)

summary(fit)

facet_wrap("lakeid")+
  