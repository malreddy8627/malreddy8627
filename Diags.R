install.packages(ISLR)
library(ISLR)
data(Default)
library(car)
head(mtcars)
dim(mtcars)#gives dimention of Data Frame this is 32 observations with 11 variables
hist(mtcars$mpg)
View(mtcars)
#1) diags target variable is following normal distribution
hist(sqrt(mtcars$mpg))

plot(mtcars$mpg, mtcars$disp)
plot(mtcars$mpg, mtcars$cyl)

fit = lm(mpg~log(hp)+wt+log(disp)  , data=mtcars)
fit = lm(mpg~., data=mtcars)

#### correlation check or Multicollinearity 
summary(fit)
cor(mtcars)
fit$residuals
### check for auto correlation and heteroscedasticity

names(fit)

library(MASS)

residuals = stdres(fit)
residuals

plot(fit$fitted.values, fit$residuals )

mtcars$normmpg = scale(mtcars$mpg)

summary(mtcars$normmpg)

 summary(fit)
 
 plot.a
hist(log(mtcars$hp))
outlierTest(fit) 
mtcars$log_hp = log(mtcars$hp)

mtcars$hp_1 = exp(mtcars$log_hp)

hist((mtcars$mpg)**-1)

qqPlot(fit, main="QQ Plot") #qq plot for studentized resid 
leveragePlots(fit) # leverage plots


#### leverage statistics

cd = cooks.distance(fit)


mtcars
head(cd)
### Cooks distance for high leverage points
cutoff <- 4/((nrow(mtcars)-length(fit$coefficients)-2))

cutoff <- 4/((nrow(mtcars)-3 -1)) 
cutoff
plot(fit, which=6, cook.levels=cutoff)


plot()

mtcars$rownum =seq(1:nrow(mtcars))
head(mtcars)

mtcars = mtcars[-c(17,20,28),]

dim(mtcars)

mtcars
names(fit)
summary(mtcars)
mtcars[17,]

## Non -normality
sresid <- studres(fit)
stres = stdres(fit)

## Reidual plots

plot(fit$fitted.values, fit$residuals )

xfit<-seq(min(sresid),max(sresid),length=40) 
yfit<-dnorm(xfit) 
lines(xfit, yfit)
names(fit)


fit$residuals


## Non-constant Error Variance
plot(stdres, fit$fitted.values)



##Multicollienearity
vif(fit)
sqrt(vif(fit)) > 2

cor(mtcars$disp, mtcars$wt)
##Non-independence of errors

durbinWatsonTest(fit)
