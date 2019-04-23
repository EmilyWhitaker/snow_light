library(lubridate)
library(ggplot2)
library(ggridges)
library(tidyverse)

decklight2 <-
  decklight %>% 
  filter(depth == 0)

lte = decklight2 %>% 
  right_join(allsnowandlight,by = c('sampledate', 'lakeid'))

lte$adjustedlight <-lte[, 5]/lte[,4]

all3month <-
  all3 %>%
  separate(sampledate, c("year", "month", "day"), sep= "-" )

all3month <- 
  all3month %>%
  mutate(
    month= as.numeric(month)
  )

ggplot(data = lte, mapping = aes(x = avsnow, y = light)) +
  geom_point(aes(color= lakeid)) +
  labs(y = 'light at 0m ',x = 'snow (cm)')


ggplot(data = lte, mapping = aes(x = whiteice, y = light)) +
  geom_point(aes(color= lakeid)) +
  labs(y = 'light at 0m ',x = 'white ice (cm)')

ggplot(data = lte, mapping = aes(x = avsnow, y = adjustedlight)) +
  geom_point(aes(color= lakeid)) +
  labs(y = 'light at 0m ',x = 'snow (cm)')

fit= lm(light ~ avsnow + totice, data= lte)

summary(fit)

facet_wrap("lakeid")+
