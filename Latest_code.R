library(ggplot2)
data(mpg)

head(mpg)

##setwd("D:\\Data Science - Course\\Random Forest")
setwd("D:\\DataScience")
churn = read.csv("Churn.csv")


### one continous variable ( histogram) 
hist(churn$Day.Mins)
mean(churn$Day.Mins)
median(churn$Day.Mins)
hist(churn$Night.Mins)

## one continious variable ( Boxplot)
boxplot(churn$Day.Mins)

str(churn)

### one categorical variable ( barchart )

churn$Churn = as.factor(churn$Churn)
Churn

barplot(churn$Churn)

table( churn$CustServ.Calls)



## Barchart - category and frequency 

## table statement provides the category and frequency 
## Prop.table converts the frequency counts to proportions
## round will round it off to one decimal e.g round( x, 1)


 freqency_per = round(prop.table(table(churn$CustServ.Calls)) * 100, 1)

barplot( freqency_per, col = rainbow(20))
barplot( table(churn$Churn), col = rainbow(20))

man_tab = round(prop.table(table(mpg$class)) * 100 , 1)

barplot( man_tab, col = rainbow(20))


## two variables 

## Two continous variables 

plot( churn$Day.Mins, churn$Night.Mins)

scatter.smooth( churn$Day.Mins, churn$Night.Mins)

plot(table(churn$Churn))


## one continous and one categorical 

churn_1 = churn[ churn$Churn == 1, ]
churn_0 = churn[ churn$Churn == 0, ]

boxplot( churn_1$Day.Mins)
boxplot( churn_0$Day.Mins )
hist( churn$Account.Length)

### introduction to ggplot2 

library(ggplot2)
data(mpg)
library(datasets) 
?datasets
library(help = "datasets")

data(BOD)

ggplot( churn, aes(Day.Mins )) + geom_histogram()

a = ggplot( churn, aes(Churn, Day.Mins ))

 a + geom_histogram()

 a + geom_boxplot()
 
 head(mpg)
 
 ggplot(mpg, aes(class, fill=class)) + geom_bar()
 
 ### two continous varaibles 
 ### scatterplot - geometric shape is geom_point
 
 ggplot(churn, aes( Day.Mins, Eve.Mins) ) + geom_point() 
 
 ## One COntinious and one factor 
 
 ggplot( mpg, aes( class, hwy)) + geom_boxplot()
 
 ggplot(mpg, aes( displ, hwy) ) + geom_point() + geom_smooth( method=lm)

 ggplot( mpg, aes(class, fill=drv )) + geom_bar()
 
 
 ggplot( mpg, aes(1, cty)) + geom_boxplot()
 
 ## more than two dimensions 
 
 ## build the basic block using continious variables 
 
 data(mpg)
 
 head(mpg)
 
 ggplot( mpg, aes( cty,hwy, size = displ, color= class, shape = drv)) + geom_point() 
 

 table( mpg$year)

 class( mpg$year) 
 
mpg$year = as.factor(mpg$year)

mpg$cyl = as.factor(mpg$cyl)
 
  a = ggplot( mpg, aes( cty,hwy, size = displ, color= class, shape = drv)) + geom_point() 

  
  a + facet_grid(cyl ~ year)
  
  ### change the look of a plot/chart 
  
   b = ggplot(mpg, aes(fl, fill = fl )) + geom_bar( )
   
   
b
  
p =  b + scale_fill_manual(
    values = c("skyblue", "royalblue", "blue", "navy"),
    limits = c("d", "e", "p", "r"), breaks =c("d", "e", "p", "r"),
    name = "fuel", labels = c("Diesel", "Electric", "Petrol", "Hybrid"))
p
 
# Add a main title above the plot

 p = p + ggtitle("Fuel type - frequency ")

## Change the label on the X axis
q = p + xlab("Fuel type")

## Change the label on the Y axis
 d = q + ylab("Frequency")
 d
 
d1 =  d + ggtitle(" Distribution of cars by Fuel type ")
d1

 ## adjust the postion of legends Place legend at "bottom", "top", "left", or "right"
 
 d2 = d1 + theme(legend.position = "top")
 
 d2
 
 ###to change the theme
 
d2 + theme_classic()


## Change the postion of bars on a bar chart 

b = ggplot( mpg, aes( year, fill=fl))
b


b + geom_bar(position = "dodge")+theme_light()
b + theme_light()

### to modify the x and y axis limits 

## using a scatter plot 

 a = ggplot( mpg, aes( cty, hwy)) + geom_point( ) + coord_cartesian( xlim=c(5,50), ylim= c(5,50))
 b =  a + theme_light() + scale_shape_manual( values = 1)
b
 
 f <- ggplot(mpg, aes(cty, hwy, shape=fl)) + geom_point( )
 
f + scale_shape_manual(values = c(1, 3, 4, 5 ,10))

f <- ggplot(mpg, aes(cty, hwy)) + geom_point( )


f + scale_shape_manual(values = 5)

ggsave("plot.pdf", plot = last_plot())

 