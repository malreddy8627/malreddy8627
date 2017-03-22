setwd("D:\\DataScience")
flights <- read.csv("flightDelays.csv", header = T, sep = ",")
head(flights)
names(flights)
######removing unwanted or non important variables from dataset
flights <- flights[-c(6,7,12)]
names(flights)

#####always check for class imbalance for classification problem
table(flights$delay)
prop.table(table(flights$delay)) #####ontime 80% and delayed 20% so it is ok.

set.seed(12345)
indx <- sample(nrow(flights), nrow(flights) * 0.80)
train <- flights[indx, ]
test <- flights[-indx, ]
#####logistic model

model2 <- glm(delay ~ . -weather -dayweek, data = train, family = "binomial")

summary(model2)

######prediction on test data
test$pred <- predict(model2, newdata = test, type = "response")
head(test)

####compare the pred values to label 
test$class <- ifelse(test$pred >= 0.5, "ontime", "delay")
head(test)
tail(test)

#####confuse matrix
table(test$delay, test$class)
