rm(list = ls())
setwd("D:\\R\\CSV")

cement = read.csv("concrete_missingvalues.csv", header = T, sep = ",")
head(cement)
colSums(is.na(cement))#gives all the missing values in dataset

# missing value in variables
table(is.na(cement$cement))

#mean(cement$cement, na.rm = TRUE)
cement$cement[is.na(cement$cement)] = mean(cement$cement, na.rm = TRUE)
mean(cement$cement)
table(is.na(cement$cement))
cement$cement = round(cement$cement, 1)

table(is.na(cement$ash))
cement$ash[is.na(cement$ash)] = mean(cement$ash, na.rm = TRUE)
cement$ash = round(cement$ash, 1)
colSums(is.na(cement))#gives all the missing values in dataset
cement$water[is.na(cement$water)] = mean(cement$water, na.rm = TRUE)
cement$water = round(cement$water, 1)
colSums(is.na(cement))#gives all the missing values in dataset
table(is.na(cement$coarseagg))
cement$coarseagg[is.na(cement$coarseagg)] = mean(cement$coarseagg, na.rm = TRUE)
cement$coarseagg = round(cement$coarseagg, 1)
colSums(is.na(cement))#gives all the missing values in dataset
# missing values replacing in factor variables
#levels(cement$cement)[levels(cement$cement)==""]="unknown"
hist(cement$strength, xlab = "Strength", ylab = "Frequency", main = "Hist of Strength in cement", col = "green")
hist(sqrt(cement$strength))
# EDA
cor(cement)
plot(cement$water, cement$superplastic)
plot(cement$cement, cement$strength)
library(ggplot2)
ggplot(cement, aes(cement, strength))+ geom_point()+ geom_smooth()+theme_classic()+geom_jitter()
plot(cement)
data_cement = cement[,-c(6,7)]
set.seed(2454)
inde = sample(nrow(data_cement), 0.8*nrow(data_cement))
train = data_cement[inde,]
test = data_cement[-inde,]
lmmodel = lm(strength ~ . , data = train)
summary(lmmodel)
test$pred = predict(lmmodel, newdata = test)
# R square = 0.6034

sqrt(mean(data_cement$strength - test$pred)^2)

