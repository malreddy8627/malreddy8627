
setwd('D:\\Data Science - Course\\Text and Naive Bayes')




library(twitteR)
##library(ROAuth)
library(plyr)
library(dplyr)
library(stringr)
library(ggplot2)


posText = read.delim(file='polarity_pos.txt', header=FALSE, stringsAsFactors=FALSE)


head(posText)
posText = posText$V1

head(posText)

 

posText = unlist(lapply(posText, function(x) { str_split(x, "\n") }))
 
 head(posText)
 
 score.sentiment <- function(sentences, pos.words, neg.words, .progress='none')
 {
   require(plyr)
   require(stringr)
   scores <- laply(sentences, function(sentence, pos.words, neg.words){
     sentence <- gsub('[[:punct:]]', "", sentence) 
     sentence <- gsub('[[:cntrl:]]', "", sentence) 
     sentence <- gsub('\\d+', "", sentence)  
     sentence <- tolower(sentence)
     word.list <- str_split(sentence, '\\s+')
     words <- unlist(word.list)
     
     pos.matches <- match(words, pos.words)
     neg.matches <- match(words, neg.words)
     pos.matches <- !is.na(pos.matches)
     neg.matches <- !is.na(neg.matches)
     score <- sum(pos.matches)  - sum(neg.matches)
     return(score)
   }, pos.words, neg.words, .progress=.progress)
   scores.df <- data.frame(score=scores, text=sentences)
   return(scores.df)
 }
 






# negText = read.delim(file='polarity_neg.txt', header=FALSE, stringsAsFactors=FALSE)
# negText = negText$V1
# negText = unlist(lapply(negText, function(x) { str_split(x, "\n") }))
# head(negText)




#load up word polarity list and format it
afinn_list = read.delim(file='AFINN-111.txt', header=FALSE, stringsAsFactors=FALSE)

head(afinn_list)
names(afinn_list) = c('word', 'score')
afinn_list$word = tolower(afinn_list$word)

head(afinn_list)

#categorize words as very negative to very positive and add some movie-specific words
vNegTerms = afinn_list$word[afinn_list$score==-5 | afinn_list$score==-4]
negTerms = c(afinn_list$word[afinn_list$score==-3 | afinn_list$score==-2 | afinn_list$score==-1], "second-rate", "moronic", "third-rate", "flawed", "juvenile", "boring", "distasteful", "ordinary", "disgusting", "senseless", "static", "brutal", "confused", "disappointing", "bloody", "silly", "tired", "predictable", "stupid", "uninteresting", "trite", "uneven", "outdated", "dreadful", "bland")
posTerms = c(afinn_list$word[afinn_list$score==3 | afinn_list$score==2 | afinn_list$score==1], "first-rate", "insightful", "clever", "charming", "comical", "charismatic", "enjoyable", "absorbing", "sensitive", "intriguing", "powerful", "pleasant", "surprising", "thought-provoking", "imaginative", "unpretentious")
vPosTerms = c(afinn_list$word[afinn_list$score==5 | afinn_list$score==4], "uproarious", "riveting", "fascinating", "dazzling", "legendary")



negterms = c(afinn_list$word[afinn_list$score < 0 ] )
posterms = c(afinn_list$word[afinn_list$score > 0 ] )

#build tables of positive and negative sentences with scores
posResult = as.data.frame(score.sentiment(posText, posterms,   negterms))
names(posResult)

head(posResult)

hist(posResult$score)

negResult = as.data.frame(score.sentiment(negText, posTerms,   negTerms))
head(negResult)
hist(posResult$score)

 hist(negResult$score)
 
 table(posResult$score)

head(posResult)

posResult

table(posResult$score)
table(negResult$score)


negativereviews = posResult[posResult$score <= -3 ,]



scores <- score.sentiment(negText, posTerms, negTerms, .progress='text')

table(scores$score)
write.csv(scores, 'scores_sentiment.csv', row.names=TRUE) #save evaluation results into the file

#total evaluation: positive / negative / neutral
stat <- scores
stat$created <- stack$created
stat$created <- as.Date(stat$created)
stat <- mutate(stat, tweet=ifelse(stat$score > 0, 'positive', ifelse(stat$score < 0, 'negative', 'neutral')))
by.tweet <- group_by(stat, tweet, created)
by.tweet <- summarise(by.tweet, number=n())
write.csv(by.tweet, file=paste(searchterm, '_opin.csv'), row.names=TRUE)

#create chart
ggplot(by.tweet, aes(created, number)) + geom_line(aes(group=tweet, color=tweet), size=2) +
  geom_point(aes(group=tweet, color=tweet), size=4) +
  theme(text = element_text(size=18), axis.text.x = element_text(angle=90, vjust=1)) +
  #stat_summary(fun.y = 'sum', fun.ymin='sum', fun.ymax='sum', colour = 'yellow', size=2, geom = 'line') +
  ggtitle(searchterm)

ggsave(file=paste(searchterm, '_plot.jpeg'))
