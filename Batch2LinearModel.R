setwd("D:\\DataScience")
Insurance <- read.csv("insurance.csv", header=T, sep = ",")
head(Insurance)
str(Insurance)
table(is.na(Insurance))
colSums(is.na(Insurance))

summary(Insurance) ###here charges is the continious variable and it is not following normal distribu
##tion coz mean and median are not equal

var(Insurance$charges)
sd(Insurance$charges)


hist(Insurance$charges) ####since charges is not following normal distribution then we need to apply
####transformations like log(), sqrt(), inv()

Insurance$log_charges <- log(Insurance$charges)
hist(Insurance$log_charges) ####more or less it is following normal distribution
head(Insurance)
####we created log_charges variable for normal distribution and this variable should be used for
###prediction so we need to remove charges variable form Insurance data frame.
Insurance <- Insurance[, -6, -7]
head(Insurance)
###or
Insurance$charges <- NULL
head(Insurance)
####above both statements are same
set.seed(12345)
indx <- sample(nrow(Insurance), nrow(Insurance) * 0.8)
train <- Insurance[indx, ]
test <- Insurance[-indx, ]

model1 <- lm(log_charges ~ ., data=train)
summary(model1)

test$pred <- predict(model1, newdata = test)

test$diff <- test$log_charges - test$pred
test$sqr_diff <- test$diff ** 2
mse <- mean(test$sqr_diff)
mse
rmse <- sqrt(mse)
rmse
#####we need to compare the actual values with rmse value
rmse/mean(test$log_charges) * 100 ##### which is less than 5% then it is good model

####linear diagnostics
data(mtcars)
head(mtcars)
summary(mtcars)
######mpg is the target variable
hist(mtcars$mpg)
hist(log(mtcars$mpg))
hist(sqrt(mtcars$mpg))
hist(1/(mtcars$mpg)) ####this is called as inversion function
cor(mtcars[ , -1]) #### here mpg is the target variable , no need to find the correlation for target
######with respect to input variables.

fit <- lm(mpg ~  hp+wt, data = mtcars)
summary(fit)

###check for autocorrelation and heteroskadasticity
names(fit)

hist(fit$residuals) ### if it is not following normal distribution then we need to calculate
### the standard residuals
library(MASS)
residuals <- stdres(fit)
hist(residuals)
summary(residuals)

fit$fitted.values
plot(fit$fitted.values, residuals)

####leverage statistics and cooks distance to find high leverage points
cd <- cooks.distance(fit)
cd

cutoff <- 4/(nrow(mtcars) - length(fit$coefficients) - 2 )
cutoof <- 4/(nrow(mtcars) - 2 - 1 )
cutoff

plot(fit, which = 4, cook.levels = cutoff) ###### high leverage points
plot(fit, which = 1, cook.levels = cutoff) #####autocorrelation and heteroskasticity
plot(fit, which = 2, cook.levels = cutoff)
plot(fit, which = 3, cook.levels = cutoff)
install.packages("car")
library(car)
#####outliers
outlierTest(fit)
vif(fit)
sqrt(vif(fit)) > 2

#### >2 then there is multicollinearity, if <2 no multicollinearity
