library(lubridate)
library(ggplot2)
library(ggridges)
library(tidyverse)

decklight2 <-
  decklight %>% 
  filter(depth == 0)

lte = decklight2 %>% 
  right_join(allsnowandlight,by = c('sampledate', 'lakeid'))



