##Hypothesis
girls <- c(2,4,5,6,7,6,7,8,9)
mean(girls)
boys <- c(6,9,9,9,9,9,9,9,9)
##Null hypothesis is both are equal girls = boys

## want to prove that girls are better than boys , this called alternate hypothesis
##by using t.test()
t.test(boys,girls,confi.level = 0.95)#, alternative = "less")
