a=10
b=20
c=a+b
c

install.packages("forecast") ## one time 

library(arules) ## everytime we want to use the library

## r is case sensitive 

A = 10 
a = 20

# naming conventions in R

# aaceptable characters in name (a-z)(A-Z)( 0-9)( . _ )

## start with a aphabet ( a-z A-Z), followed by a special character and number 

a.1 = 20
a_1 = 30
a1. = 40 ## as a programming standard avoid this 

## aphabet + spl.character + numeric 

 ## assignment operators in R 

=  , <- 
  
  a = 10 ## preferable assignment operator  
a <- 20
 10 -> a
 
## R is case sensitive 
 
 # a is not same as A
 
  a= "Apple"
  b = "apple"
a ==  b

## Data structures in R 

## one dimensional data structure 
 10,20,30,40 ## homogenous 
 10, 20 , "a", "b" ## Heterogenous 
 
 a = c( 10,20,30,40)
 
 class(a)
 
## a is a vector : 
 
 b = c( 10,20, "a", "b")
 class(b)

 
 ## two dimensinal data structures in R ( data frame)
 ## read data into R 
  getwd() ## current working directory 
  
  setwd("D:\\Data Science - Course\\Decision_Tree") ## chnage the working directory 
 
  getwd()
  
  df1 =  read.csv("credit.csv")
  
  df2 = rfead.csv( "/Data Science - Course/Random Forest/Churn.csv")
  
  read.csv()
  
  
