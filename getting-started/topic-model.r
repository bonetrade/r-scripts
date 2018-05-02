library(mallet)

#turning the user_id into a character

my_data$owner_id <- as.character(my_data$owner_id) 

documents <- data.frame(text = my_data$caption,
                       id = make.unique(my_data$owner_id),
                       class = my_data$taken_at_timestamp, 
                        stringsAsFactors=FALSE)
mallet.instances <- mallet.import(documents$id, documents$text, "en.txt", token.regexp = "\\p{L}[\\p{L}\\p{P}]+\\p{L}")
## the stopwords file isi added humanbone and humanskull to the stopwords since those were original search terms
## and because skull, skulls, human are extremely prominent after so doing, we add those in too.
## the stopwords list is that which comes bundeled with MALLET, http://mallet.cs.umass.edu/


## Create a topic trainer object.
n.topics <- 25
topic.model <- MalletLDA(n.topics)

## Load our documents. We could also pass in the filename of a 
##  saved instance list file that we build from the command-line tools.
topic.model$loadDocuments(mallet.instances)

## Get the vocabulary, and some statistics about word frequencies.
##  These may be useful in further curating the stopword list.
vocabulary <- topic.model$getVocabulary()
word.freqs <- mallet.word.freqs(topic.model)

## Optimize hyperparameters every 20 iterations, 
##  after 50 burn-in iterations.
topic.model$setAlphaOptimization(20, 50)

## Now train a model. Note that hyperparameter optimization is on, by default.
##  We can specify the number of iterations. Here we'll use a large-ish round number.
topic.model$train(1000)

## NEW: run through a few iterations where we pick the best topic for each token, 
##  rather than sampling from the posterior distribution.
topic.model$maximize(10)

## Get the probability of topics in documents and the probability of words in topics.
## By default, these functions return raw word counts. Here we want probabilities, 
##  so we normalize, and add "smoothing" so that nothing has exactly 0 probability.
doc.topics <- mallet.doc.topics(topic.model, smoothed=T, normalized=T)
topic.words <- mallet.topic.words(topic.model, smoothed=T, normalized=T)
# from http://www.cs.princeton.edu/~mimno/R/clustertrees.R
## transpose and normalize the doc topics
topic.docs <- t(doc.topics)
topic.docs <- topic.docs / rowSums(topic.docs)

write.csv(doc.topics, file = "GIVE-A-USEFUL-NAME-HERE.csv")

## Get a vector containing short names for the topics
topics.labels <- rep("", n.topics)
for (topic in 1:n.topics) topics.labels[topic] <- paste(mallet.top.words(topic.model, topic.words[topic,], num.top.words=10)$words, collapse=" ")
# have a look at keywords for each topic
topics.labels

# this is where you might decide that some word is appearing too frequently - an artefact of your collections strategy, perhaps, so you'd add it to your stop list and start again.

