#parsing the basedata

#remove all the depths that arent zeros

basedata %>% filter(depth == 0)
