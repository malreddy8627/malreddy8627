setwd("D:\\DataScience")
df1 <- read.csv("Churn.csv")
head(df1)

str(df1)
hist(df1$Day.Mins)
summary(df1$Day.Mins)
sd(df1$Day.Mins)
var1 <- var(df1$Day.Mins)
sd <- sqrt(var1)
plot(df1$State)
plot(df1$Day.Mins, df1$Eve.Mins)
cor(df1$Day.Mins, df1$Eve.Mins)###almost this is equal to zero , then there is no correlation

########ggplotting by ggplot2
install.packages("ggplot2")
library(ggplot2)
install.packages("lattice")
library(caret)
####one continious variable
ggplot(df1, aes(Day.Mins)) + geom_histogram(binwidth = 30)
ggplot(df1, aes(1,Day.Mins)) + geom_boxplot()

######two dimentional plots
#### two continious variables
ggplot(df1, aes(Account.Length, Day.Mins)) + geom_point() + geom_smooth()
ggplot(df1, aes(Day.Mins, Day.Charge)) + geom_point() + geom_smooth()
cor(df1$Day.Mins, df1$Day.Charge)

#####one continious and one factor variable
ggplot(df1, aes(State, Day.Mins)) + geom_boxplot()

####converting churn variable to factor variable
df1$Churn <- ifelse(df1$Churn == 1, "yes", "no")
df1$Churn

####one factor variable and one continious variable 
ggplot(df1, aes(Churn, Day.Mins)) + geom_boxplot() + geom_smooth()

###two factor variables, if two factor variables use "fill" for one of that
df1$Intl.Plan <- as.factor(df1$Intl.Plan)
ggplot(df1, aes(Churn, fill =Intl.Plan)) + geom_bar(position="dodge")

table(df1$Churn, df1$Intl.Plan)
prop.table(table(df1$Churn, df1$Intl.Plan))
crossTable(df1$Churn, df1$Intl.Plan)
?crossTable
###multidimentional plots
data("mpg")
head(mpg)
str(mpg)
ggplot(mpg, aes(cty, hwy, color=class, shape=fl, size=cyl)) + geom_point()
table(mpg$cyl, mpg$fl, mpg$class)
