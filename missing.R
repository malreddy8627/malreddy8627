setwd("d:\\r\\csv")
rm(list = ls())
conmis=read.csv("concrete_missingvalues.csv")
str(conmis)# gives structure of the dataframe with variable types
dim(conmis)#gives dimentions of dataframe
head(conmis)#shows the top6 observations
tail(conmis,15)# shows the bottom 6 observations
summary(conmis)#gives min,max,mean,median,1st&3rd quartile and also gives count of missing values in a per variable
??ggplot
library(tibble)
glimpse(conmis)
colSums(is.na(conmis))
colSums(conmis)
table(is.na(conmis$cement))
mean(conmis$cement)
a=mean(conmis$cement, na.rm = TRUE)
a
b=round(a)
b
conmis$cement[is.na(conmis$cement)] = b
table(is.na(conmis$cement))
mean(conmis$cement)

conmis$ash[is.na(conmis$ash)]=mean(conmis$ash,na.rm = TRUE)
table(is.na(conmis$ash))
summary(conmis$water)
head(conmis$water)
colSums(conmis)
colSums(is.na(conmis))
#replacing with -99

conmis$water[is.na(conmis$water)]=-99
colSums(is.na(conmis))
summary(conmis$coarseagg)

mean(conmis$coarseagg, na.rm = TRUE)
head(conmis$coarseagg)
conmis$coarseagg[is.na(conmis$coarseagg)]=-50
camp=read.csv("campaign.csv")
str(camp)
?filter
write.csv(conmis,"conmis2.csv")
