
library(gbm)

credit = read.csv("D:/Data Science - Course/Decision_Tree/credit.csv")


credit$default = ifelse(credit$default == "yes", 1 ,0)

table(credit$default)


target = credit$default  ## seperating the target variable

credit= credit[, -17]

head(credit)

library(dummies)
credit.matrix = dummy.data.frame(credit)
head(credit.matrix)

credit.matrix1 = cbind(target, credit.matrix)

set.seed(1234)

indx = sample(nrow(credit.matrix1), nrow(credit.matrix1)*0.8)

train = credit.matrix1[ indx,]
test = credit.matrix1[-indx,]

head(credit.matrix1)


train_target = train$target
test_target = test$target





library(gbm)



gb =gbm( train$target ~ . , data = train, n.trees = 50, distribution = "bernoulli" , shrinkage = 0.1, interaction.depth = 12) # , shrinkage = 0.1, interaction.depth = 8) #verbose = T) #, shrinkage = 0.01  ) #,shrinkage = 0.01 ,interaction.depth = ,verbose=T)
names(gb)  #n.trees=1000 , shrinkage = 0.01 ,interaction.depth = 8,verbose=T)

summary(gb)

?gbm





test$pred  = predict(gb, newdata= test, n.trees= 50,  type="response")

hist(test$pred)


test$pred_class = ifelse( test$pred >= 0.5, 1,0)

library(gmodels)

CrossTable(test$target , test$pred_class)

table( test$target, test$pred_class)


setwd("D:\\Data Science - Course\\Random Forest")

df1 = read.csv("churn.csv")

prop.table(table(df1$Churn))

names(df1)


df1 = df1[, -(19:21)]

str(df1)

library(dummies)

df2 = dummy.data.frame(df1)

rm(df1)

set.seed(1234)

samp = sample( nrow(df2), nrow(df2)*0.7 )
train = df2[samp, ]
test = df2[-samp, ]

library(gbm)

gbm1 = gbm( Churn ~ ., data=train, distribution = "bernoulli", n.trees=200, shrinkage = 0.1, interaction.depth = 15 ) #, shrinkage = 0.01 , interaction.depth = 14, verbose = 2, cv.folds = 5) #, verbose = T, interaction.depth = 6, n.minobsinnode = 20, cv.folds = 3)

summary(gbm1)

gbm1$cv.error

names(gbm1)

test$pred = predict( gbm1, newdata=test, type="response", n.trees = 200)

hist(test$pred) ## histogram of predicted probabilities

test$pred_class = ifelse( test$pred >= 0.5, 1, 0)


table(test$Churn, test$pred_class)

library(gmodels)

CrossTable( test$Churn, test$pred_class)

2* 0.91*0.71/(0.71+0.91)


library(xgboost)

target = df1$Churn 

names(df1)

df1 = df1[ , -c(8,19:21)]

str(df1)


sum( is.na(df1))

df1[ is.na(df1)] = -99
list = ''

for ( i in 1 : ncol(df1 )) {

  
  if sum(is.na(df1[,i]) > 0 {
    list = c( list, i)
  }
}



set.seed(1234)
idx = sample(nrow(df1), nrow(df1)*0.8)
train = df1[idx, ]
test = df1[-idx,]

y = target[ idx]
test_target = target[ -idx]

xgb1 = xgboost(data =  data.matrix(train), 
               label = y, 
               eta = 0.01,
               max_depth = 7, 
               nround=1901,  
               #subsample = 0.5,
               #colsample_bytree = 0.5,
               alpha = 1,
               eval_metric = "error",
               objective = "binary:logistic",
               nthread = 3)


y_pred = predict(xgb1, data.matrix(test))

y_class = ifelse( y_pred >=0.5, 1, 0)

library(gmodels)

CrossTable(test_target, y_class)

table(test_target, y_class )

2*0.768*0.894/(0.768+0.894)


summary(xgb1)
?xgboost
  