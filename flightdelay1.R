setwd("D:\\DataScience")

library(boot)
library(MASS)


flights <- read.csv("FlightDelays.csv", header=T, sep=",")
head(flights)
tail(flights)
dim(flights)
str(flights)
names(flights)

table(flights$weather)

table(flights$delay)

## class Imbalance on target variable coz it is factor variable  

prop.table(table(flights$delay ))*100


### convert below variables from int to factor
head(flights)
flights$weather <- as.factor(flights$weather)
head(flights)
##class(flights$delay)
flights$delay <- as.factor(flights$delay) # no need to convert coz alredy it is factor variable.
##head(flights)

table(flights$weather)
###plotting for input variable and target variable
library(ggplot2)

ggplot(flights, aes( delay,fill= weather)) + geom_bar()

## convert the delay variable to binary ( 0 , 1)

flights$delay = ifelse(flights$delay =="ontime", 0, 1)
head(flights)
str(flights)
##once convert into binary , the data type changed again to number, then we have to convert into factor
##variable again
flights$delay = as.factor(flights$delay)
str(flights)

## diff b/w scheduled and departure time 

flights$diff <- flights$schedtime - flights$deptime
head(flights)


##look at input variables, if they are not significent enough to participate into model then exclude 
##here itself 
names(flights)
file3 = flights[ , -c(6,7,12 )]
names(file3)

### ggplot(file2, aes(delay)) + geom_bar(aes(fill=weather),position = "stack")
 

set.seed(1234)


sub = sample(nrow(file3), nrow(file3) * 0.7)
train = file3[sub, ]
test = file3[-sub, ]

### Generalised linear models for  logistic regression

##model3 = glm(delay ~ . ,  data=train, family="binomial")

model3 = glm(delay ~ . -weather -dayweek -diff ,  data=train, family="binomial")
summary(model3)

### Predict probability on test data using model3
head(test)
test$pred = predict(model3, newdata=test, type="response")
head(test)


### convert the probability to a class variable ( > 0.5 is delayed , <=0.5 is "ontime" )

test$pred_class = ifelse(test$pred >= 0.4, 1,0)
head(test)

## cross table(confusion matrix) of two discrete variables

table(test$delay, test$pred_class)


precision <- 80/84
precision

accuracy <- 517 + 80 / 517 + 80 + 4 +60
accuracy

recall <- 80/140
recall

93/140

f1_square <- 2*0.95*0.57/(0.95+0.57)
f1_square #####till here enough

##(517+80)/661

library(caret)

confusionMatrix(test$delay, test$pred_class)

##79/(91)
##79/(79+48)

##2*0.86*0.62/(0.86+0.62)


library(e1071)
library(AUC)
library(ROCR)
library(ggplot2)
library(caret)

 ?confusionMatrix

model4 = glm(delay ~ . -schedtime -deptime - weather -dayweek -diff ,  data=train, family="binomial")

summary(model4)

test$pred1 = predict(model4, newdata=test, type="response")
head(test)
test$pred_class1 = ifelse( test$pred1 >= 0.5, "yes", "no")
head(test)

table(test$delay, test$pred_class1)


## roc graph 
library(ROCR)

pred <- prediction(test$pred, test$delay)
perf <- performance(pred,"tpr","fpr")
plot( perf)
pred2 <- prediction(test$pred1, test$delay)
perf2 <- performance(pred2,"tpr","fpr")
plot( perf)
plot(perf2, add = TRUE, colorize = TRUE)


###we need to find out the auc area under curve this is final step
auc <- performance(pred, measure = "auc")
auc <- auc@y.values[[1]]
auc

