library(lubridate)
library(ggplot2)
library(ggridges)
library(tidyverse)
install.packages(ggjoy)
library(ggjoy)
#spilt indivually then join at depth 0? 


#first manipulate for PAR @ 0
Total_lights <- 
  
  
  
  
# Calculate duration of northern ice
iceDatesN = read_csv('ntl32_v5.csv') # Northern
iceDatesS = read_csv('ntl33_v4.csv') %>% # Southern
  mutate(firstice = as.Date(ice_on,'%m/%d/%Y'), lastice = as.Date(ice_off,'%m/%d/%Y'), ice_duration = as.numeric(ice_duration), year4 = lead(as.numeric(year4))) %>%
  dplyr::select(year = year4,lakeid,ice_duration, firstice, lastice)


iceDatesCombo2 = iceDatesN %>% 
  mutate(datefirsticeN = lag(datefirstice), firsticeN = lag(firstice)) %>%
  dplyr::mutate(firstIceX = ifelse(firsticeN < 100,0-firsticeN,365 - firsticeN), duration = lastice + firstIceX) %>%
  dplyr::mutate(firstIceX = ifelse(firsticeN < 100,0-firsticeN,365 - firsticeN), duration = lastice + firstIceX) %>%
  dplyr::select(year, lakeid, ice_duration = duration, firstice = datefirsticeN, lastice = datelastice) %>%
  bind_rows(iceDatesS) %>%
  mutate(firsticeYDAY = ifelse(yday(firstice) <50, yday(firstice) + 365,yday(firstice)), lasticeYDAY = yday(lastice)) %>%
  mutate(iceon = as.Date('2000-01-01') + firsticeYDAY, iceoff = as.Date('2001-01-01') + lasticeYDAY)

lakestats = read_csv('LTERlakes.csv') 

dtf = iceDatesCombo %>% dplyr::select(lakeid,iceon,iceoff) %>%
  gather(group,date,iceon:iceoff) %>%
  dplyr::filter(lakeid != 'LR') %>%
  left_join(lakestats,by = c('lakeid'='LakeAbr'))

ggplot(dtf,aes(x = date,  fill = group,
               y = light)) +
  scale_x_date(date_breaks = "1 month", date_labels =  "%b")  +
  geom_density_ridges(scale = 2,alpha = .5,rel_min_height = 0.01,
                      jittered_points = TRUE,
                      position = position_points_jitter(width = 0.05, height = 0),
                      point_shape = '|', point_size = 1) + 
  scale_fill_discrete(name = '') + 
  labs(y = '',x = '') 


theme_joy() +
