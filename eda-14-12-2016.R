library(ISLR)
data("Default")

head(Default)


## One continious variable 

## Base plotting 
hist(Default$balance,breaks = 50)


### Log transformation 

hist( sqrt(Default$balance), breaks=50)

boxplot(Default$balance)

### one variable ( factor) 

head(Default)

barplot(prop.table(table(Default$student)))

table(Default$student)

pie(prop.table(table(Default$student)))


## ggplot2
library(ggplot2)


b = ggplot( Default, aes(1, balance))

ggplot( Default, aes( balance)) + geom_histogram()

ggplot(Default, aes(1, sqrt(balance))) + geom_boxplot()

## one factor variable 

ggplot( Default, aes(student, fill=student)) + geom_bar()

ggplot(Default, aes(default, fill=default)) + geom_bar()

a = ggplot(Default, aes(student, fill=student))

a + geom_bar()

b + geom_histogram()
b + geom_boxplot()

## two variables 

## one continious and continiuos 

ggplot( Default, aes(balance, income)) + geom_point()

## one continiuos and one factor 
 ggplot(Default, aes(default, balance)) + geom_boxplot()
 
 ## factor and factor 
 
ggplot( Default, aes(student, fill=default)) + geom_bar(position = "fill")


### multidimensional plot 
setwd("D:\\Data Science - Course\\Decision_Tree")
credit = read.csv("credit.csv")

library(ggplot2)
head(credit)

 a = ggplot(credit, aes(months_loan_duration, amount, color = employment_duration , shape =  default, size = existing_loans_count)) + geom_point()

table(credit$job)

a + facet_grid( job ~ phone)

b = a  + ggtitle("The Credit Plot") + xlab("Duration of loan - Months")

c = b + ylab("Loan amount in $")

c + coord_cartesian( xlim = c( 0, 65), ylim = c()) + theme(legend.position = "right")




