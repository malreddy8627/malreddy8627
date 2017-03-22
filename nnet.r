#### Program to demonstrate Neural Networks \
### Objective : Regression 
## Author : Charan 

setwd("D:\\Data Science - Course\\NN")
concrete = read.csv("concrete.csv")
str(concrete)
 # Normalize
normalize =  function(x) { 
  return((x - min(x)) / (max(x) - min(x)))
}

hist(concrete$strength)
hist(sqrt(concrete$strength))

cor( concrete)

names(concrete)
# normalization
concrete_norm = as.data.frame(lapply(concrete, normalize))

# confirm that the range is now between zero and one
summary(concrete_norm$strength)

hist(concrete_norm$strength)

# compared to the original minimum and maximum
summary(concrete$strength)

concrete = cbind( concrete[, 9], concrete_norm)

concrete$strength = concrete[, 1]

concrete[, 1] = NULL

# create training and test data
set.seed(12345)
indx = sample(nrow(concrete), nrow(concrete)*0.6)
train = concrete_norm[ indx, ]
test = concrete_norm[-indx, ]

# train the neuralnet model

names(train)


library(neuralnet)
?neuralnet ## to check the model function 
# simple ANN with only a single hidden neuron
concrete_model = neuralnet(formula = strength ~ cement + slag +
                              ash + water + superplastic + 
                              coarseagg + fineagg + age,
                              data = train )


# visualize the network topology
plot(concrete_model)

## Evaluating model performance 
# obtain model results
model_results = compute(concrete_model, test[,1:8])
model_results
# obtain predicted strength values
predicted_strength = model_results$net.result

test$predicted_strength = model_results$net.result

test$res_sq = (test$strength - test$predicted_strength)**2

sqrt(mean(test$res_sq))

mean(test$strength)

(0.11/0.41)*100
cor(test$strength, test$predicted_strength)


# examine the correlation between predicted and actual values
cor(predicted_strength, test$strength)

##  Improving model performance ----
# a more complex neural network topology with 5 hidden neurons
concrete_model2 = neuralnet(strength ~ cement + slag +
                               ash + water + superplastic + 
                               coarseagg + fineagg + age,
                               data = train, hidden = c(5,3,2))


plot(concrete_model2)

# obtain model results
model_results = compute(concrete_model2, test[, 1:8])
model_results
# obtain predicted strength values
predicted_strength = model_results$net.result

test$predicted_strength = model_results$net.result

test$res_sq = (test$strength - test$predicted_strength)**2

sqrt(mean(test$res_sq))

mean(test$strength)

(0.07/0.41)*100

cor(test$strength, test$predicted_strength)
# plot the network
plot(concrete_model2)

# evaluate the results as we did before
model_results2 = compute(concrete_model2, test[1:8])

model_results2 = compute(concrete_model2, test[1:8])
predicted_strength2 = model_results2$net.result
cor(predicted_strength2, test$strength)


head(predicted_strength2)

