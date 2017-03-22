library(ISLR)
data(Default)
library(car)
head(mtcars)
head(mtcars)
dim(mtcars)

hist(mtcars$mpg)

### Target variable - Normal distribution 

hist(mtcars$mpg)

hist((1/mtcars$mpg))

### relationship b/w input and target variabes 

plot(mtcars$hp, mtcars$mpg)


### Mullticollinearity 

cor( mtcars[ , -1 ])

head(mtcars)
hist(mtcars$mpg)

cor(mtcars$carb, mtcars$am)

fit = lm(mpg  ~  hp+wt , data=mtcars)


#### correlation check or Multicollinearity 
summary(fit)
 cor(mtcars)

### check for auto correlation and heteroscedasticity

names(fit)

fit$residuals

library(MASS) ## need to calculate standardised residuals

residuals = stdres(fit)
summary(residuals)

hist(residuals)

mtcars$mpg_s = scale(mtcars$mpg)

summary(mtcars$mpg_s)


plot(fit$fitted.values, residuals )

durbinWatsonTest(fit)

outlierTest(fit)

### MAAS 

mtcars$normmpg = scale(mtcars$mpg)

summary(mtcars$normmpg)

 summary(fit)
hist(log(mtcars$hp))

mtcars

### 

 



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

cutoff <- 4/((nrow(mtcars)-2 -1)) 
cutoff
plot(fit, which=5, cook.levels=cutoff)

vif(fit)


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

durbinWatsonTest(fit) ## Autocorrelation

  ## Outlier test 

outlierTest(fit)
