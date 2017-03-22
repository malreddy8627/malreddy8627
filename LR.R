### Your project drive 
setwd("D:\\Data Science - Course\\Linear Regression") ## update your location of the file 
insurance = read.csv("insurance.csv")

head(insurance)

hist(insurance$charges)

boxplot((insurance$charges))

 insurance$charges_log = log(insurance$charges)
 
 hist(insurance$charges_log)
 
 boxplot(insurance$charges_log)
 
 cor(insurance$age, insurance$children)

 
## EDA 
## Normal distribution of target variable
hist(log(insurance$charges))
dim(insurance)
head(insurance)
str(insurance)


# EDA relationship b/w input and target variables.

cor(insurance$bmi, log(insurance$charges))

insurance$log_charges = log(insurance$charges)


insurance$charges = NULL
head(insurance)

### Split data into training and testing 

set.seed(123) 

idx = sample(nrow(insurance), nrow(insurance) * 0.8)
idx
train = insurance[ idx,]
test = insurance[ -idx,]

## model building "Linear Model"

model1 = lm(charges_log ~ . , data=train)

summary(model1)

head(test)


### Predicting using model1 and save the predictions on test data frame

test$y_pred = predict(model1, newdata=test)
head(test)
summary(model1)

head(test)

## residuals

test$diff = test$charges_log - test$y_pred

## Squared residuals

test$diff_sq = test$diff ** 2


##RMSE


sqrt(mean(test$diff_sq))

cor(test$y_pred, test$charges_log)

plot(test$charges_log, test$y_pred)

test$diff_sq = test$diff ** 2




## Calculate the mean squared error
 mean(test$charges_log) ## MSE 
   
 sqrt(mean(test$diff_sq)) ## RMSE
   
   
hist(insurance$charges)
summary(log(insurance$charges))
insurance$charges_log = log(insurance$charges)
hist(insurance$charges_log)
boxplot(log(insurance$charges))
model1 = lm(charges_log~ . -charges, data=insurance)
summary(model1)

### Mullticollinearity
cor(insurance[ , -1 ])







