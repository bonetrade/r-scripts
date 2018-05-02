###
# how to separate into two columns
# tidyr to the rescue I guess?
library(tidyr)

df <- separate(my_data, taken_at_timestamp, into = c("date", "time"), sep = " (?=[^ ]+$)")

# check to see whether or not the data is in the character class:
sapply(df, class)

# and we can see that both are 'character'. We need to change that.

# convert the date column to actual date (ie, it was 'character')
df$date <- format(as.Date(df$date), "%Y/%m/%d")

#or possibly

df$date <- as.Date(df$date)