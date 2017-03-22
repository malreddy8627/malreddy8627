mtcars

d <- dist(mtcars)
d
hist(d)
plot(d)
plot(hclust(d))

d <- dist(as.matrix(mtcars))   
hc <- hclust(d, method="single")
?hclust
memb <- cutree(hc, k=7)
plot(hc)                     
