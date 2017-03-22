###Prediction models
setwd("D:\\DataScience")
insurance_df1 <- read.csv("insurance.csv")
dim(insurance_df1)
head(insurance_df1)
names(insurance_df1)

##all variables as input and insurance is target variable
### relationship b/w input and target variable
cor( insurance_df1$charges, insurance_df1$bmi) #.19 positive relationship but week relationship
cor( insurance_df1$charges, insurance_df1$age) #.29 positive but not so strong rest other variables are factor variable

### here we have to use plot here

## target variable 

hist(insurance_df1$charges)
boxplot(insurance_df1$charges)
######dropping variable 


### transformations functions to change the distribution to make target variable 
##normal variable

## log transformation 

insurance_df1$charges_log = log(insurance_df1$charges)
insurance_df1$charges_log
head(insurance_df1)
mean(insurance_df1$charges_log)

hist(insurance_df1$charges_log)
### here we have to use plot here

table(insurance_df1$region)
#########insurance$charges <- NUll then it will remove charges column
insurance_df1$charges <- NULL
head(insurance_df1)

set.seed(123)#same data will be included in sample no matter how many times we repeat

idx = sample(nrow(insurance_df1), 0.8*nrow(insurance_df1))#split the data into training and testing
idx

train = insurance_df1 [idx, ]
test = insurance_df1[-idx, ]
dim(train)
dim(test)

relation_model2 = lm(charges_log ~ . , data=train)
summary(relation_model2)


test$pred = predict(relation_model2,newdata = test)
head(test)

#####residual value 
test$residual <- test$charges_log - test$pred
head(test)
########inorder to make the residual value as positive we need to square off residual
test$residual_sqr <- test$residual ** 2
head(test)

######find out the MSE mean square error 

test_mse <- mean(test$residual_sqr)
test_mse

####find out rmse
test_rmse <- sqrt(test_mse)
test_rmse

summary(test$charges_log)

#avg error / avg of charges for knowing the % value error 
(0.465/9.09)*100
(test_rmse/mean(insurance_df1$charges_log))*100 
names(insurance_df1)
library(ggplot2)

ggplot(relation_model2, aes(bmi, col = age, shape = sex, 
                            size = children)) + facet_grid(charges_log ~ .) + geom_point()

##ggplot(relation_model2, aes(charges_log, bmi, col = age, shape = sex, 
##                   size = children)) + geom_point()

# 1) mean of Bo is 7.02 and 68% or 1 SD or Std.Error = 0.08 as 1 sd range is between 6.94 and 7.1
# 2) T test if p value is <0.05 alt hypo is true***. if there is no * we can exclude or keep as per requirement
# 3) R squire= 1-RSS/Tss, residual sum of squares, Tss total sum of square R2 should be >.6,.9 is excellent
# 4) adjusted R2 is what would be r2 after changing seed adj r2 will always be less than r2
# 5) F-Stats is predicting using avg price or null model without using input variable 
# 6) p-value is less than 0.05 alt hyp is better
# 7) To see how is test data is performing we do RMSE 
# 8) RMSE is avg error 
# 8) few residual are negetive and positive chances are sum=0 so we square the residuals
# 9) Find the mean of squared mean and perform the squareroot i got 0.46
# 10) RMSe values should as small as possible so i am making 0.46 +- of target


plot()
