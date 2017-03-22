a=10
a=c(1,2,3,4)
a[2]
a[1]
a=c(1:100)
a
length(a)
class(a)
a=c(10.5,12.5,10,14)
length(a)
p=60
a=c(10,20,30,40,50,pi)
a[3]
pi=4
pi
a <- "a"

## Arithematic operations 


## If and else conditions 

#Comparison Operators

equal: ==
  not equal: !=
  greater/less than: > <
  greater

/less than or equal: >= <=
a=NULL  
  a=10
  a <= 20

# Logical operations 
  
  and:  &
  or:  |
  not: !
  
  a= 10 

b = ifelse(a<=10, 20, 10)

a=c(20,30,40,50,60)  # <25,  25-35 , 35-45,  45+

d = seq(from = 1 , to =length(a), by = 2)
d
 b =NULL
for ( i in seq(from = 1 , to =length(a), by = 2)) {
if ( a[i]< 25 ) {
  b[i]="<25"
} else if(a[i] >= 25 & a[i] < 35) {
  b[i]="25-35"
} else if ( a[i] >=35 & a[i]< 45) {
  b[i]="35-45" 
} else b[i]="45+"

}
b

## Loops ( for )
getwd()
setwd("D:\\Data Science - Course\\Decision_Tree")
credit = read.csv(file = "credit.csv",header = T, sep = ",")
class(credit)
?dim(credit)
head(credit)

str(credit)

credit[1:10,-(3:17)]

credit$loan_dur_year = credit$months_loan_duration/12

credit_good = credit[credit$credit_history =="good",]



credit$def = ifelse(credit$default == "yes", 1, 0)

table(credit$def,credit$credit_history, credit$job)

summary(credit)

?sd(credit$amount)

Merging Data 

dat3=?merge(dat1,dat2,by="ID") ##merge two tables by ID field. 
dat3=merge(dat1,dat2,by.x="ID",by.y="STN")
dat3=merge(dat1,dat2,by=c("LAT","LONG"))
dat3=merge(dat1,dat2,by.x="ID",by.y="ID",all.x=T,all.y=F) ## left merge; 
##Other types of merge conditions
all.x=F, all.y=T  #right merge; 
all.x=T,all.y=T #keep all rows; 
all.x=F,all.y=F # keep matching rows

#Row and col merge (binding)

Rowbind(data1, data2)
Colbind(data1,data2)



write.csv(credit, "newfile.csv",row.names=F)
