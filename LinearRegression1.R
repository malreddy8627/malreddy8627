setwd("D:\\R\\CSV")
insurance = read.csv("insurance.csv")
names(insurance)
### relationship b/w input and target variable
cor( insurance$charges, insurance$bmi) #.19 positive relationship but week relationship
cor( insurance$charges, insurance$age) #.29 positive but not so strong rest other variables are factor variable

## target variable 

hist(insurance$charges)
boxplot(insurance$charges)


### transformations to change the distribution to make target variable normal variable

## log transformation 

insurance$target = log(insurance$charges)
#insurance$charges_sq=sqrt(insurance$charges)
#insurance$charges_iv = 1/(insurance$charges) 
  
#insurance$charges_sq = NULL # way of deleting variables
#insurance$charges_iv = NULL # way of deleting variables

hist(insurance$target)
table(insurance$region)
head(insurance)
#insurance$target = log(insurance$charges)
 
insurance$charges = NULL



set.seed(123)#same data will be included in sample no matter how many times we repeat
idx = sample(nrow(insurance), 0.8*nrow(insurance))#split the data into training and testing
train = insurance [idx, ]
test = insurance[-idx,]



 model1 = lm( target ~ . , data=train   )
summary(model1)


test$pred = predict(model1,newdata = test)

test$predcharges = exp( test$pred)

head(test)

## error is difference b/w predicted and actual values
test$derr = test$pred - test$target

## error is positive and negative - calculate squared errors
test$derrsqr = test$derr^2


## mean of squared error - is MSE 
head(test)

mean(test$derrsqr)

## mean on linear terms 

sqrt( mean(test$derrsqr)) ## RMSE 

mean(train$target)

### rmse 

sqrt(sum(test$derrsqr/nrow(test)))

#avg error / avg of charges for knowing the % value error 
(0.465/9.09)*100

