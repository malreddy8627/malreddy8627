# Load data
data(iris)

head(iris)


cor( iris[, 1:4])

target = iris[, -5]

table(iris$Species)
# log transform 

hist(iris$Petal.Width)

### applying log transformation to adjust the distributions
log.ir <- log(iris[, 1:4])

###
hist(log.ir[,4])
head(log.ir)

### Check the correlation b/w input variables 

plot(iris[,1:4])
cor(iris[,1:4])
ir.species <- iris[, 5]
cor(iris$Petal.Length , iris$Petal.Width)

# apply PCA - scale. = TRUE is highly 
# advisable, but default is FALSE. 
ir.pca <- prcomp(log.ir,
                 center = TRUE,
                 scale. = TRUE)

?prcomp

print(ir.pca)

ir.pca

pcaCharts <- function(x) {
  x.var <- x$sdev ^ 2
  x.pvar <- x.var/sum(x.var)
  print("proportions of variance:")
  print(x.pvar)
  
  par(mfrow=c(2,2))
  plot(x.pvar,xlab="Principal component", ylab="Proportion of variance explained", ylim=c(0,1), type='b')
  plot(cumsum(x.pvar),xlab="Principal component", ylab="Cumulative Proportion of variance explained", ylim=c(0,1), type='b')
  screeplot(x)
  screeplot(x,type="l")
  par(mfrow=c(1,1))
}

pcaCharts(ir.pca)

# plot method
plot(ir.pca, type = "l" )

# summary method
summary(ir.pca)

# Predict PCs
predict(ir.pca, 
        newdata=tail(log.ir))

 x= predict(ir.pca, newdata=log.ir)
 
 head(x)
 
 cor(x)
 
 

head(x)

setwd("D:\\Data Science - Course\\KNN")

cancer_Data = read.csv("wisc_bc_data.csv")

head(cancer_Data)

cor(cancer_Data[,3:32])

cancer_pca <- prcomp(cancer_Data[ , 3:32],
                 center = TRUE,
                 scale. = TRUE)

cancer_pca


str(cancer_Data)

cor( cancer_Data[ , 3:32])

plot(cancer_pca_input$PC1 , cancer_pca_input$PC2)


pcaCharts(cancer_pca)


cancer_pca_input = as.data.frame(predict( cancer_pca, newdata= cancer_Data[ , 3:32]))

head(cancer_pca_input)

cor(cancer_pca_input)

cacner_pca_data = cbind( cancer_Data[, 2],cancer_pca_input )

head(cacner_pca_data)

cacner_pca_data$target = cacner_pca_data[ , 1]



cacner_pca_data = cacner_pca_data[ , -1]

head(cacner_pca_data)

set.seed(123)

idx = sample( nrow(cacner_pca_data), nrow(cacner_pca_data)*0.8)

train  = cacner_pca_data[ idx, ]
test  = cacner_pca_data[ -idx, ]


glm1 = glm( as.factor(target) ~ PC1 + PC2+PC3+PC4+PC5+PC8+PC9, data=train, family="binomial")



summary(glm1)
test$pred = predict( glm1, newdata=test, type="response")

test$class = ifelse( test$pred >= 0.5, "M", "B")

table(test$target , test$class)


  library(gmodels)
CrossTable(test$target , test$class)


 iris_1 = as.dat`a.frame( cbind(x,iris[,5]))
colnames(iris_1) = c('p1','p2','p3','p4','species')
head(iris_1)


library(nnet)

model_pc = multinom(species ~ p1 + p2 , data =iris_1, family="poisson")

summary(model_pc)


library(ggplot2)
 
iris_1$species = as.factor(iris_1$species)
ggplot(iris_1, aes(p1,p2, color=species)) + geom_point()


 ## devtools

## PCA for visualization 
 
library(ggbiplot)
g <- ggbiplot(ir.pca, obs.scale = 1, var.scale = 1, 
              groups = ir.species, ellipse = TRUE, 
              circle = TRUE)
g <- g + scale_color_discrete(name = '')
g <- g + theme(legend.direction = 'horizontal', 
               legend.position = 'top')
ir.pca

print(g)




 
