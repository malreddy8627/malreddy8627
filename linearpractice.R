insurance=read.csv("d:\\r\\csv\\insurance.csv")
head(insurance)
#Exploratory data analysis
cor(insurance$charges,insurance$age)
cor(insurance$charges,insurance$bmi)
cor(insurance$age,insurance$bmi)
hist(insurance$charges)
hist(log(insurance$charges))
insurance$target=log(insurance$charges)
class(insurance$target)
insurance$charges=NULL
names(insurance)
set.seed(123)
indexan=sample(nrow(insurance),nrow(insurance)*.8)
train=insurance[indexan,]
test=insurance[-indexan,]
model1=lm(target~., data = train)
summary(model1)
test$predi=predict(model1,newdata=test)
test$residual=test$target-test$predi
test$resi_square=test$residual**2
MSE=mean(test$resi_square)
MSE
RMSE=sqrt(MSE)
RMSE
head(test)
test$diff=NULL
summary(test$target)
#Validate the model
summary(model1)
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
      
# Multiple Linear Regression Example 
#fit <- lm(y ~ x1 + x2 + x3, data=mydata)
#summary(fit) # show results

# Other useful functions 
#coefficients(fit) # model coefficients
#confint(fit, level=0.95) # CIs for model parameters 
#fitted(fit) # predicted values
residuals(fit) # residuals
anova(fit) # anova table 
vcov(fit) # covariance matrix for model parameters 
influence(fit) # regression diagnostics 
