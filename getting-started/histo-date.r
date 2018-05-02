# so let's now visualize the date data

library(tidyr)

#df - this was from the small dataset apr10
df <- separate(my_data, taken_at_timestamp, into = c("date", "time"), sep = " (?=[^ ]+$)")

# ---
# https://stackoverflow.com/questions/10770698/understanding-dates-and-plotting-a-histogram-with-ggplot2-in-r
library("ggplot2")

#---
df$date <- as.Date(df$date) 

#https://www.datacamp.com/community/tutorials/make-histogram-ggplot2#bins
qplot(df$date,
      geom="histogram",
      binwidth = 50,  
      main = "Histogram for Posts by Year", 
      xlab = "Date",  
      fill=I("blue"), 
      col=I("black"), 
      alpha=I(.2))

#---

#https://www.datacamp.com/community/tutorials/make-histogram-ggplot2#bins
qplot(my_data$taken_at_timestamp,
      geom="histogram",
      binwidth = 100,  
      main = "Histogram for Posts by Year", 
      xlab = "Date",  
      fill=I("blue"), 
      col=I("black"), 
      alpha=I(.2))

# http://astrostatistics.psu.edu/su07/R/html/graphics/html/hist.POSIXt.html
hist(my_data$taken_at_timestamp, "years", format = "%Y")
