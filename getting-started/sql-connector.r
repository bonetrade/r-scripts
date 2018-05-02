# learning how to bring data in from sqlite db
# following http://tiffanytimbers.com/querying-sqlite-databases-from-r/
# also perhaps this https://www.r-bloggers.com/using-sqlite-in-r/

library(DBI)
library(RSQLite)

# connect
# con = dbConnect(SQLite(), dbname="apr102018.sqlite")
con = dbConnect(SQLite(), dbname="2018-04-23-alltags.sqlite")

# see what's inside
alltables = dbListTables(con)

# grab what you want
# this will grab date
myQuery <- dbSendQuery(con, "SELECT id, owner_id, caption, taken_at_timestamp FROM unique_posts")

# grab text for data mining etc.

# pass that information to an R object
my_data <- dbFetch(myQuery, n = -1)

# clear cache etc
dbClearResult(myQuery)

# now carry on.



