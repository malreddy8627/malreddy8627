#assign the value to variable
a <- 10
# print a
a
#define vector
b <- c(10, 20, 30, 40, 50, 60)
#print b
b[c(1:4, 6)]
class(b)
#defile list
d <- c("a", 2, "h", 4)
#print d
d
class(d)

e <- c(1, 2, 4)
f <- c(7,, 6, 8)
#create the matrix
m <- as.matrix(cbind(e, f))
m

k <- matrix(1:21, byrow = FALSE, ncol = 3)
k

getwd("C:/Users/dheeraja/Desktop/Data-Science/credit.csv")
head(credit, 20)

#assign the winnings / losses by creating  pocker_vector and roulette_vector
pocker_vector <- c(40, -50, 20, -120, 240)
roulette_vector <- c(-24, -50, 100, -350, 10)
pocker_vector

days_vector <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
days_vector

some_vector <- c("John de", "Poker player")
names(some_vector) <- ("Name", "Profession")

names(some_vector)
some_vector


getwd("C:/Users/dheeraja/Desktop/Data-Science/credit.csv")
# setwd("Desktop/Data-Science/credit.csv")
inputfile1 <- read.csv("credit.csv", header = TRUE, sep = ",")
# print input
inputfile2 <- inputfile1[1:100, 1:10]
inputfile2

setwd("d:\\csv\\credit.csv")
a=read.csv("credit.csv")
head(a)
input <- a[1:100, 1:10]
input
output <- a[1:20, c(1,10,17)]
output

