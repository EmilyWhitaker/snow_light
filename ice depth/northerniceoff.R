library(lubridate)
library(ggplot2)
library(ggridges)
library(tidyverse)
basedata %>% filter(depth == 0)

iceDatesN = read_csv('ntl32_v5.csv')  # Northern

iceDatesCombo = iceDatesN %>% 
  mutate(datefirsticeN = lag(datefirstice), firsticeN = lag(firstice)) %>%
  dplyr::mutate(firstIceX = ifelse(firsticeN < 100,0-firsticeN,365 - firsticeN), duration = lastice + firstIceX) %>%
  dplyr::mutate(firstIceX = ifelse(firsticeN < 100,0-firsticeN,365 - firsticeN), duration = lastice + firstIceX) %>%
  dplyr::select(year, lakeid, ice_duration = duration, firstice = datefirsticeN, lastice = datelastice) %>%
  mutate(firsticeYDAY = ifelse(yday(firstice) <50, yday(firstice) + 365,yday(firstice)), lasticeYDAY = yday(lastice)) %>%
  mutate(iceon = as.Date('2000-01-01') + firsticeYDAY, iceoff = as.Date('2001-01-01') + lasticeYDAY)

lakestats = read_csv('LTERlakes.csv') 

dtf = iceDatesCombo %>% dplyr::select(lakeid,iceon,iceoff) %>%
  gather(group,date,iceon:iceoff) %>%
  dplyr::filter(lakeid != 'LR') %>%
  left_join(lakestats,by = c('lakeid'='LakeAbr'))



ggplot(dml,aes(x = sampledate,  fill = light,
               y = reorder(Characteristic,Latitude,function(x)-min(-x)))) +
  scale_x_date(date_breaks = "1 month", date_labels =  "%b")  +
  geom_density_ridges(scale = 2,alpha = .5,rel_min_height = 0.01,
                      jittered_points = TRUE,
                      position = position_points_jitter(width = 0.05, height = 0),
                      point_shape = '|', point_size = 1) + 
  scale_fill_discrete(name = '') + 
  labs(y = '',x = '') 



  facet_grid("lakeid")

ggplot(dml,aes(x = date,  fill = light, y = reorder(Characteristic,Latitude,function(x)-min(-x)))) +
  scale_x_date(date_breaks = "1 month", date_labels =  "%b")  +
  geom_density_ridges(scale = 2,alpha = .5,rel_min_height = 0.01,
                      jittered_points = TRUE,
                      position = position_points_jitter(width = 0.05, height = 0),
                      point_shape = '|', point_size = 1) + 
  scale_fill_discrete(name = '') + 
  labs(y = '',x = '')
  
ggsave('icedates2.png', width = 7, height = 4)



ggplot(dml3,aes(x = date,  fill = light, y = reorder(Characteristic,Latitude,function(x)-min(-x)))) +
  scale_x_date(date_breaks = "1 month", date_labels =  "%b")  +
  geom_density_ridges(scale = 2,alpha = .5,rel_min_height = 0.01,
                      jittered_points = TRUE,
                      position = position_points_jitter(width = 0.05, height = 0),
                      point_shape = '|', point_size = 1) + 
  scale_fill_discrete(name = '') + 
  labs(y = '',x = '')
