#parsing the basedata

#remove all the depths that arent zeros

all3 <-
  all_2 %>% 
  filter(depth == 0)

all4 <- as.Date(all3, sampledate, c(%Y-%m-%d))
  

all3 <-
  all3 %>%
  separate(sampledate, c("month", "day", "year"), sep= "/", extra = "merge")

all3 <-
  all3 %>%
  mutate(
    month = as.numeric(month)
  )

all3 <-
  all3 %>%
  mutate(
    year = as.numeric(year)
  )

a2 <-
  basedatadates%>% 
  filter(depth == 0)

ggplot(data = all3, mapping = aes(x = month, y = light)) +
  geom_point(aes(color= lakeid)) +
  facet_wrap("lakeid")
  

ggplot(data = all3, mapping = aes(x = year, y = light)) +
  geom_point(aes(color= lakeid)) +
  facet_wrap("lakeid")



#group into winter and summer 




#find ice on and ice off lable as winter and summer 

dtf = iceDatesCombo %>% dplyr::select(lakeid,iceon,iceoff) %>%
  gather(group,date,iceon:iceoff) %>%
  dplyr::filter(lakeid != 'LR') %>%
  left_join(lakestats,by = c('lakeid'='LakeAbr'))

basedatadates <-
  basedata %>%
  separate(sampledate, c("year", "month", "day"), sep= "-", extra = "merge")
  