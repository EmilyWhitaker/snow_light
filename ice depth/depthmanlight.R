#parsing the basedata

#remove all the depths that arent zeros

all3 <-
  all_2 %>% 
  filter(depth == 0)


all3$sampledate <- as.Date(all3$sampledate , "%y/%m/%d")


ggplot(data = all3, mapping = aes(x = month, y = light)) +
  geom_point(aes(color= lakeid)) +
  facet_wrap("lakeid")
  

ggplot(data = all3, mapping = aes(x = year, y = light)) +
  geom_point(aes(color= lakeid)) +
  facet_wrap("lakeid")

ggplot(all3, mapping = aes(x = sampledate, y = light))+
  geom_point(aes(color= lakeid))


lakestats = read_csv('LTERlakes.csv') 

dml = iceDatesCombo %>% dplyr::select(lakeid,iceon,iceoff) %>%
  gather(group,date,iceon:iceoff) %>%
  dplyr::filter(lakeid != 'LR') %>%
  left_join(all3,by = c('lakeid')) %>%
  left_join(lakestats,by = c('lakeid'='LakeAbr'))



ggplot(dml,aes(x = sampledate,  fill = group, y = light)) +
  scale_x_date(sampledate_breaks = "1 month", sampledate_labels =  "%b") +
  geom_density_ridges(scale = 2,alpha = .5,rel_min_height = 0.01,
                      jittered_points = TRUE,
                      position = position_points_jitter(width = 0.05, height = 0),
                      point_shape = '|', point_size = 1) + 
  scale_fill_discrete(name = '') + 
  labs(y = '',x = '') 


ggplot(dml,aes(x = sampledate,  fill = group, y = light)) +
  scale_x_date(date_breaks = "1 month", date_labels =  "%b")  +
  scale_y_discrete(expand = c(0.01, 0)) +
  geom_density_ridges(scale = 2,alpha = .5,rel_min_height = 0.01,
                      jittered_points = TRUE,
                      position = position_points_jitter(width = 0.05, height = 0),
                      point_shape = '|', point_size = 1) + 
  scale_fill_discrete(name = '') + 
  labs(y = '',x = '')




#group into winter and summer 




#find ice on and ice off lable as winter and summer 

dtf = iceDatesCombo %>% dplyr::select(lakeid,iceon,iceoff) %>%
  gather(group,date,iceon:iceoff) %>%
  dplyr::filter(lakeid != 'LR') %>%
  left_join(lakestats,by = c('lakeid'='LakeAbr'))

basedatadates <-
  basedata %>%
  separate(sampledate, c("year", "month", "day"), sep= "-", extra = "merge")
  