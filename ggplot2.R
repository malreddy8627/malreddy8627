setwd("D:\\Data Science - Course\\Exploratory data analysis")
qplot(data = , color=, shape=,)

qplot(circumference,age,data=Orange, ## Data used
      color=Tree, ## Aesthetic mapping
      geom=c("point","smooth"),method="lm",se=FALSE)

ggplot(data=Orange, ## Data frame
       aes(x=circumference,y=age, color=Tree))+ ## Aesthetic
  geom_point()+ ## Geometry
  stat_smooth(method="lm",se=FALSE) ## Statistics
data(iris)

head(iris)

qplot(Petal.Length, data=iris, geom="histogram", fill=Species) ## Histogram
qplot(Petal.Length, data=iris, geom="density") ## Density plot

qplot(Petal.Length, data=iris, geom="histogram", color=Species)
qplot(Petal.Length, data=iris, geom="density", color=Species)

## with Fill

qplot(Petal.Length, data=iris, geom="histogram", color=Species,
      fill=Species)
qplot(Petal.Length, data=iris, geom="density", color=Species,
      fill=Species)
IRIS
## transparent 
qplot(Petal.Length, data=iris, geom="histogram", color=Species,
      fill=Species, alpha=I(0.2))
qplot(Petal.Length, data=iris, geom="density", color=Species,
      fill=Species, alpha=I(0.2))

qplot(y=Petal.Length, data=iris, geom="boxplot")
boxplot(iris$Petal.Length)
qplot(Species, Petal.Length, data=iris, geom="boxplot")
l?qplot
## Bar Chart
qplot(Species, data=iris, geom="bar", fill=Species)
ggplot(data=iris, aes(x=Species, fill=Species)) + geom_bar()

qplot(Petal.Length,Petal.Width , data=iris, geom="boxplot", color=Species)

ggplot(data=iris, aes( y=Petal.Length,x=Species, color=Species))+geom_boxplot()

head(mpg)
g=  ggplot(mpg, aes(class, hwy, fill=fl))
g1 = g + geom_bar(stat = "identity",position = "dodge")
g1 + theme_bw()

?ggplot

## Save the plots

ggsave("plot.png", width = 5, height = 5)

lm2 = lm(hwy ~ . -cty, data=mpg)
summary(lm2)



