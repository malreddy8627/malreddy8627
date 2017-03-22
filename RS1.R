
library(recommenderlab) # package being evaluated
library(ggplot2) # For plots
data(MovieLense)


affinity.matrix<- as(MovieLense,"realRatingMatrix")

u.Rec.model<-Recommender(affinity.matrix[1:943], method = "UBCF")

I.Rec.model<-Recommender(affinity.matrix[1:943], method = "IBCF")



recommended.items.u1 <- predict(u.Rec.model, affinity.matrix["5",], n=3)
as(recommended.items.u1, "list")

## Itembased predictions
recommended.items.u1 <- predict(I.Rec.model, affinity.matrix["5",], n=3)
as(recommended.items.u1, "list")
# to obtain the top 3
recommended.items.u1 <- bestN(recommended.items.u1, n = 3)
# to display them
as(recommended.items.u1.top3, "list")

scheme <- evaluationScheme(MovieLense, method = "split", train = .9,
                           k = 1, given = 10, goodRating = 4)

?evaluationScheme

algorithms = list("user-based CF" = list(name="UBCF", param=list(normalize = "Z-score",
                                                                  method="Cosine",
                                                                  nn=50, minRating=3)))

results <- evaluate(scheme, algorithms, n=c( 1, 2, 3, 5,10,20, 50))

## ROC curve of the model 


plot(results, annotate = 1:4, legend="topleft")


library(kernlab)

ksvm()

?ksvm
 