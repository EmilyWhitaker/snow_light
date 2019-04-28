bluwhiteice <- 
  bluwhiteice %>%
  separate(sampledate, c("month", "day", "year"), sep= "-" )


write.csv(bluwhiteice, "bluewhiteice.csv")
all3month <-
  all3 %>%
  separate(sampledate, c("year", "month", "day"), sep= "-" )
