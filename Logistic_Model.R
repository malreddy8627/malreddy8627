rm(list = ls())
setwd("d:\\datascience")
insurance= read.csv("insurance.csv")
head(insurance)
str(insurance)
insurance$smoker=ifelse(insurance$smoker=="yes",1,0)#ifelse for converting to 1-0
head(insurance)
mod=glm(smoker~.-children , data=insurance, family = "binomial")#dummy model to identify significant variable
summary(mod)# based on *** identifying varible

set.seed(123)

ind=sample(nrow(insurance), nrow(insurance)* 0.7)

train = insurance[ind, ]
test =insurance[-ind,]

mod1 = glm(smoker~.-children, data = train, family = "binomial")# making 1st model 
summary(mod1)

test$pred = predict(mod1, newdata = test, type = "response")
head(test)

test$pred1 = ifelse(test$pred > 0.5, 1, 0)
head(test)
library(boot)
library(MASS)
library(ggplot2)
library(gplots)
library(ROCR)
library(lattice)
library(caret)
library(e1071)
library(AUC)
library(gmodels)

#CrossTable(table(test$smoker, test$pred1))
CrossTable(test$smoker, test$pred1)
2*0.89*0.89/(0.89+0.89)#f1 score
#ROC graph
pred <- prediction(test$pred1, test$smoker)
perf <- performance(pred,"tpr","fpr")
plot( perf)

#Model2
mod2 = glm(smoker~.-children -region -sex, data = train, family = "binomial")
mod2
summary(mod2)
names(mod1)

test$pred2 = predict(mod2, newdata = test, type = "response")
head(test)

test$pred2 = ifelse(test$pred2 > 0.5, 1, 0)
head(test)

CrossTable(test$pred2, test$smoker)
2*0.89*0.87/(0.89+0.87)#f1 score of mod 2
#repeating ROC graph for mod1
pred <- prediction(test$pred1, test$smoker)
perf <- performance(pred,"tpr","fpr")
plot( perf)
# comparing mod1 and mod2 in ROC graph
pred <- prediction(test$pred2, test$smoker)
perf2 <- performance(pred,"tpr","fpr")
plot( perf)
plot(perf2, add = TRUE, colorize = TRUE)
