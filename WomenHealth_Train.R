rm(list = ls())
setwd("D:\\DataScience")

WomenHealth = read.csv("WomenHealth_Training.csv", header = T, sep = ",")
head(WomenHealth)
str(WomenHealth)
dim(WomenHealth)
WomenHealth$religion
summary(WomenHealth)

# missing value in variables of the data frame
table(is.na(WomenHealth))

colSums(is.na(WomenHealth))#gives all the missing values in dataset

#mean(crime$Crime_Rate, na.rm = TRUE)
#crime$Crime_Rate[is.na(crime$Crime_Rate)] = mean(crime$Crime_Rate, na.rm = TRUE)
#mean(crime$Crime_Rate)
#table(is.na(crime$Crime_Rate))
#head(crime)
#crime$Crime_Rate = round(crime$Crime_Rate, 1)
#head(crime)

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

names(WomenHealth)

WomenHealth = WomenHealth[ ,-c(1,2,3,4,5,7,8,9,10,11,12,13,14,15,16,17,19,22,24,26,27,28,30,31,32
                               ,33,34,35,40,42,43,44,50)]
names(WomenHealth)

set.seed(12454)
indx = sample(nrow(WomenHealth), 0.8*nrow(WomenHealth))
indx
train = WomenHealth[indx, ]
test = WomenHealth[-indx, ]

Womenmodel = lm(religion ~ . , data = train)
summary(Womenmodel)

test$pred = predict(lmmodel, newdata = test)
# R square = 0.6034
head(test)

sqrt(mean(crime$Crime_Rate - test$pred)^2)

