rm(list = ls())
setwd("D:\\r\\csv")
house=read.csv("houseprices.csv", stringsAsFactors = FALSE)
head(house)
summary(house)
str(house)
#doing a KNN require all numerical variable converting type of house to numeric
house$size=house$TypeofHouse
house$TypeofHouse=NULL
head(house)
library(car)

house$size=recode(house$size,"'Small House' = 1; 'Medium House' = 2; 'Big House'=3")
head(house)
str(house)
house$fire=house$Fireplace
#house$fire=as.factor(house$fire)
house$Fireplace=NULL
head(house)

prop.table(table(house$fire))

# i am trying to predict if houses have fire place or not using KNN

# create normalization function min-max normalisation
normalize = function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}

head(house)
?lapply
firehouse <- as.data.frame(lapply(house[1:7],normalize))
str(firehouse)
#house$size=as.numeric(house$size)
str(house)
#firehouse <- as.data.frame(lapply(house[1:7],normalize))
names(firehouse)
summary(firehouse)
set.seed(123)
inde=sample(nrow(firehouse), nrow(firehouse)*.8)
train1=firehouse[inde,]
test1=firehouse[-inde,]
head(train1)
#creating lables or target
 fireplace_train=house[inde,8]
 head(fireplace_train)
Fireplace_test=house[-inde,8]
str(Fireplace_test)
#building a model
library(class)
predictfireplace=knn(train=train1,test = test1,
                     cl = fireplace_train, k = 21)

#table(predictfireplace)
#table(Fireplace_test)
summary(predictfireplace)
library(gmodels)
CrossTable(Fireplace_test,predictfireplace)
table(Fireplace_test,predictfireplace)
str(predictfireplace)

(2*.81)*.78/(.81+.78)

