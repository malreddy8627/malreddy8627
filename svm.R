setwd("D:\\DataScience")
install.packages("kernlab")
library("kernlab")

letters <- read.csv("letterdata.csv")

letter_a = letters[letters$letter == "A", ]



head(letter_a)

str(letters)

head(letters)

prop.table(table(letters$letter))


set.seed(1235)
# divide into training and test data
idx = sample(nrow(letters), nrow(letters)*.7)

train = letters[idx, ]
test = letters[-idx,]

library("e1071")

?svm
?ksvm

##Training a model on the data ----
## begin by training a simple linear SVM
library(kernlab)
letter_classifier <- ksvm(letter ~ ., data = train,
                          kernel = "vanilladot")




?ksvm
# look at basic information about the model
letter_classifier

##  Evaluating model performance ----
# predictions on testing dataset
letter_predictions <- predict(letter_classifier, test)

head(letter_predictions)

table(test$letter, letter_predictions )

# look only at agreement vs. non-agreement
# construct a vector of TRUE/FALSE indicating correct/incorrect predictions
agreement = letter_predictions == test$letter
table(agreement)
5125/(5125+875)
prop.table(table(agreement))

##Improving model performance ----
letter_classifier_rbf <- ksvm(letter ~ ., data = train, kernel = "rbfdot")
letter_predictions_rbf <- predict(letter_classifier_rbf, test)

summary(letter_classifier_rbf)

agreement_rbf <- letter_predictions_rbf == test$letter
table(agreement_rbf)

5603/(5603+397)
prop.table(table(agreement_rbf)) 

## polynomial kernel
letter_classifier_plo <- ksvm(letter ~ ., data = train, kernel = "splinedot")
letter_predictions_plo <- predict(letter_classifier_plo, test)
  
agreement_plo <- letter_predictions_plo == test$letter 
table(agreement_plo)
prop.table(table(agreement_plo)) 


plot(letter.pca, type = "l" )
pcaCharts(letter.pca)

head(test_pc)

test_lablels = cbind(test_pc,test[,1])
head(test_lablels)

test_labels = as.data.frame(test_lablels)
head(test_labels)


