# convert unix epoch time to human time
install.packages("anytime")
library(anytime)
my_data$taken_at_timestamp <- anydate(my_data$taken_at_timestamp)
