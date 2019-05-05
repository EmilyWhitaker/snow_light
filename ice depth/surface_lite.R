library(tidyverse)
library(lubridate)
library(ggplot2)

### using df lte


#edit to 0m only--- already done

# need blueice 
lte_blu<-
  lte %>%
  mutate(blueice = totice - whiteice)


# % surface light
lte_lite <-
  lte_blu %>%
  mutate(surflite = light / deck)

write.csv(lte_lite, 'lte_lite.csv')

## linear model

fit = lm(surflite ~ avsnow + whiteice +totice+ blueice, data = lte_lite)

summary(fit)

fit2 = lm(surflite ~ avsnow + whiteice + blueice, data = lte_lite)

summary(fit2)

#organize into plots

ggplot(data = lte_lite_2, mapping = aes(x = avsnow, y = surflite)) +
  geom_point(aes(color= lakeid))+
  labs(y = 'light at 0m ',x = 'snow (cm)')
  


ggplot(data = lte_lite_2, mapping = aes(x = whiteice, y = surflite)) +
  geom_point(aes(color= lakeid)) +
  labs(y = 'light at 0m ',x = 'white ice (cm)')

ggplot(data = lte_lite_2, mapping = aes(x = blueice, y = surflite)) +
  geom_point(aes(color= lakeid)) +
  labs(y = 'light at 0m ',x = 'black ice (cm)')

ggplot(data = lte_lite_2, mapping = aes(x = totice, y = surflite)) +
  geom_point(aes(color= lakeid)) +
  labs(y = 'light at 0m ',x = 'total ice (cm)')

ggplot(data = lte_lite_2, mapping = aes(x = sampledate, y = surflite)) +
  geom_point(aes(color= avsnow)) +
  labs(y = 'light at 0m ',x = 'date')+
  facet_wrap('lakeid')


#cut into months and yrs-- wait
lte_lite_dates<- 
  lte_lite_2 %>%
  separate(sampledate, c("month", "day", "year"), sep= "/", extra = "merge")


lte_lite_dates <-
  lte_lite_dates %>%
  mutate(
    month = as.numeric(month)
  )
lte_lite_dates <-
  lte_lite_dates %>%
  mutate(
    year3 = as.numeric(year)
  )

##replot

ggplot(data = lte_lite_dates , mapping = aes(x = month, y = surflite)) +
  geom_point(aes(color= avsnow)) +
  labs(y = 'light at 0m ',x = 'month')+
  facet_wrap('lakeid')

ggplot(data = lte_lite_dates , mapping = aes(x = month, y = surflite)) +
  geom_point(aes(color= lakeid)) +
  labs(y = 'light at 0m ',x = 'month')
  



