library(ISLR) ## For default dataset
library(rpart) ## we need this package for cart algoritm to build the decission tree models  			        
#library(rattle)
install.packages("rpart.plot")
library(rpart.plot)				
library(RColorBrewer)	
install.packages("party")
library(party)					
library(partykit)				
library(caret)
install.packages("rattle")
library(rattle)
library(ggplot2) ## for qplot fucntion 

data(Default)
head(Default)

train <- as.data.frame(Default)
head(train)
sum(is.na(train))

train[is.na(train)] = 0

# comment 

train <- as.data.frame(Default)

head(train)

train[1:10,2:3]

qplot(balance, income, data=train, color=default, shape=student)

library(rpart)
tree1 <- rpart(as.factor(default) ~ . , data=Default, method = "class")

plot(tree1)
text(tree1)
fancyRpartPlot(tree1) # it says error saying that fancyRpartPlot function is not found.
 
 
### Rpart
 setwd("D:\\DataScience")
 
 credit = read.csv("credit.csv")
 head(credit)
 table(credit$default)
 prop.table(table(credit$default)) ## Proportion of yes and no this is called class imbalance check
 
 set.seed(12345)
 indx = sample(nrow(credit), nrow(credit)*0.8)
 
 train = credit[indx, ]
 test = credit[-indx, ]

  str(credit) # to find out the default variable is weather continious variable or factor variable, if it 
## factor variable then we have to give as.factor(default) in the model building.
 
 rparttree = rpart(as.factor(default) ~ ., data=train, method="class" )
 
 summary(rparttree)
 
 ### print the CP matrix 
 
 prop.table(table(train$default))
 
 printcp(rparttree) ###complexcity parameter
 
 fancyRpartPlot(rparttree)
 
 test$pred = predict(rparttree, newdata=test, type="class" )
 
 install.packages("gmodels")
 library(gmodels)

 confusionMatrix(test$default, test$pred ) ## inorder to calculate manually precision, recall and f1 square
 ## we have to create confusion matrix, if we want to avoid manual calculations we should go for CrossTable
 ##function
 
 CrossTable(test$default, test$pred)
 
precision <- 31/62 
precision

recall <- 31/57
recall

f1 = 2*0.5*0.54/(0.54+0.5) 
f1 ### here f1 square is 0.519, so this model is ok but not good, if it is >0.7 then that is good model

#### inorder to increase the f1 square value we have to go for pruning the tree, pruning menas cutting 
###of fully grown tree by using cp value like below. 

 tree2 = prune(rparttree , cp = 0.0124)###pruning the tree
 
 fancyRpartPlot(tree2)
 

 ### prune the tree 
 
 treepruned = prune( rparttree, cp=0.01235 )
 
 fancyRpartPlot(treepruned)
 
 ## test using pruned tree 
 
 test$pred1 = predict( tree2, newdata=test, type="class")
 
 head(test$pred1)
 
 ##test$pred1_class = ifelse(test$pred1[,2] >= 0.5, "yes","no")
 test$pred1_class = ifelse(test$pred1 >= 0.5, 1,0)
 confusionMatrix(test$default, test$pred1) 
 CrossTable(test$default, test$pred1)
 
 precision <- 30/59
 precision
 
 recall <- 30/57
 recall
 
 f1 = 2*0.5*0.52/(0.52+0.5) 
 f1 ### still here f1 square is 0.50, so this model is ok but not good, if it is >0.7 then that is 
 ##good model ,, do the same 
 
 
 #### CHurn Prediction for classification tree
 
 setwd("D:\\DataScience")
 
 data = read.csv("churn.csv")
 
 head(data)
 
 names(data)
 
 
 data = data[ , -(19:21)]
 names(data)
 str(data)
 
 set.seed(708)
 
 idx = sample(nrow(data), nrow(data)*0.8)
 
 train = data[idx, ]
 test = data[-idx, ]
 
 chrun_tree = rpart( as.factor(Churn) ~ ., data=train, method="class")

 fancyRpartPlot(chrun_tree)
 
 printcp(chrun_tree)
 
 test$pred = predict(chrun_tree, newdata=test, type="class")
 
 CrossTable(test$Churn, test$pred) ## Unpruned tree
 
 2*0.733*0.928/(0.928+0.733) # unpruned tree ( f1 - 0.82)
 
 
 Churn_tree_p = prune( chrun_tree, cp = 0.01059 )## pruning by changing cp value
 
 fancyRpartPlot(Churn_tree_p)

test$pred1 = predict( Churn_tree_p, newdata = test, type="class")
 
CrossTable(test$Churn, test$pred1) ## pruned tree

2*0.696*0.936/(0.936+0.695) ## pruned tree ( f1- 0.8)

## using the above cp value
printcp(chrun_tree)

Churn_tree_p2 = prune( chrun_tree, cp = 0.0146)

test$pred2 = predict( Churn_tree_p2, newdata = test, type="class")

CrossTable(test$Churn, test$pred2)

2*0.667*0.933/(0.933+0.667)## pruned tree ( f1- 0.77)

##from above all that first f1 square value is bigger as 0.81 so that is good model
 


### Random Forest  example
install.packages("randomForest")
 
library(randomForest)
data(Default)
head(Default)
dim(Default)

  rf1 = randomForest(as.factor(default) ~ . , data=train, n.trees=400, mtry = 4, max_depth = 30, 
                     class_wt = c(0.80, .20))
  
  ###this default contains 10000 observations and 4 columns or variables, mtry equal to square root of m
  ###here m = 4 variables, so square root of 4 is 2, so in the model we have to give mtry = 2, that 
  ### means two random variables in the each node. if we will not specify mtry = 2 in the model , it will 
  ## assume as default value mtry = 2.
  
  ###n.trees, by using rf1$ntree we will number of trees , in this case 500 trees are there , we can 
  ##observe the prediction values by changing this n.trees value in model for ex... n.trees = 100
  ##then check prediction or n.trees = 50 check prediction , same for max_depth also 
  
  rf1$ntree
 
 varImp(rf1) ### here we can come to know that importance of fields
 
 varImpPlot(rf1)#### here also  we will come to know the importance of input fields
 ###in the plot, top one is first important and like that
 
 test$pred = predict(rf1, newdata=test)
 
 CrossTable(test$default, test$pred)
 
 ### randomForest on flight delay datasets 
 
 ## read the filight delyas file 
 
 file2 <- read.csv("FlightDelays.csv", header=T, sep=",")
 dim(file2)
 file2$diff = file2$schedtime - file2$deptime
 
 
 set.seed(123)
 
 idx = sample(nrow(file2), nrow(file2)*0.7)
 
 train1 = file2[ idx,]
 test1 = file2[-idx,]
 
names(train1)

### class balance 

prop.table(table(train1$delay))



##rf2 = randomForest( as.factor(delay) ~ . -flightnumber -tailnu -date, data=train1, n.trees=1000, classwt = c(0.2, 0.8), mtry = 6 , maxnodes = 10) #, classwt=c(0.4, 0.6), mtry = 6, maxnodes=20)

rf2 = randomForest( as.factor(delay) ~ . -flightnumber -tailnu -date, data=train1, n.trees=1000, 
                    class_wt = c(0.2, 0.8), mtry = 6 , max_depth = 10)
#, classwt=c(0.4, 0.6), mtry = 6, maxnodes=20)

varImpPlot(rf2)

test1$pred = predict(rf2, newdata=test1)

CrossTable(test1$delay, test1$pred)

 
 
library(randomForest)


rf_mod = randomForest( default ~ . , data=train, ntree=500, mtry = 5, max_depth = 3)

summary(rf_mod)

rf_mod$ntree

test$predict = predict( rf_mod, newdata=test)


table( test$default, test$predict)

30/46
30/57

2*0.65*0.52/(0.52+0.65)


setwd("D:\\Data Science - Course\\Random Forest")


churn = read.csv( "churn.csv")

prop.table( table( churn$Churn))

churn$Area.Code = NULL
churn$Phone = NULL

set.seed(123)
indx1 = sample( nrow(churn), nrow(churn)*0.7)

train1 = churn[ indx1, ]
test1 = churn[ -indx1, ]

churn_rf = randomForest(as.factor(Churn) ~ . , data=train1 , ntree=200, mtry = 5
, max_depth = 5  )
churn_rf$ntree

train1$pred = predict( churn_rf, newdata=train1)

table(test1$Churn, test1$pred)

table(train1$Churn, train1$pred)
60/61
60/150
2*0.98*0.4/(0.4+0.98)

(2000+172)/2333
(849+81)/1000


library(gmodels)
CrossTable(test1$Churn, test1$pred)

names(churn_rf)

churn_rf$importance

varImpPlot(churn_rf)
