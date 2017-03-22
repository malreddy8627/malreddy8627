rm(list = ls())
setwd("D:\\DataScience")

crime = read.csv("CrimeRate.csv", header = T, sep = ",")
head(crime)

# missing value in variables of the data frame
table(is.na(crime))

colSums(is.na(crime))#gives all the missing values in dataset

#mean(crime$Crime_Rate, na.rm = TRUE)
crime$Crime_Rate[is.na(crime$Crime_Rate)] = mean(crime$Crime_Rate, na.rm = TRUE)
mean(crime$Crime_Rate)
table(is.na(crime$Crime_Rate))
head(crime)
crime$Crime_Rate = round(crime$Crime_Rate, 1)
head(crime)

hist(crime$Crime_Rate)
hist(log(crime$Crime_Rate))

hist(sqrt(crime$Crime_Rate))
hist(1/crime$Crime_Rate)
# EDA
cor(crime)

plot(crime$Crime_Rate, crime$Voilence_rate)
plot(crime$Crime_Rate, crime$Illetrates)
library(ggplot2)
ggplot(crime, aes(Crime_Rate, Voilence_rate ))+ geom_point()+ geom_smooth()+theme_classic()+geom_jitter()
plot(crime)
names(crime)

crime = crime[,-c(3,4,5,6,7)]
names(crime)

set.seed(2454)
indx = sample(nrow(crime), 0.8*nrow(crime))
train = crime[indx,]
test = crime[-indx,]

lmmodel = lm(Crime_Rate ~ . , data = train)
summary(lmmodel)
test$pred = predict(lmmodel, newdata = test)
# R square = 0.6034
head(test)

sqrt(mean(crime$Crime_Rate - test$pred)^2)

