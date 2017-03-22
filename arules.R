setwd('D:\\Data Science - Course\\AR')

load(titanic.raw)
head(titanic.raw)


library(arules)



head(titanic.raw)


 prop.table(table(titanic.raw$Survived))
 
 ### apriori algo 
 
rules = apriori(titanic.raw)
rules.sorted = sort(rules, by="lift")
inspect(rules.sorted)

prop.table(table(titanic.raw$Survived))

rules = apriori(titanic.raw,
                 parameter = list(minlen=2, supp=0.005, conf=0.8),
                 appearance = list(rhs=c("Survived=No", "Survived=Yes"),
                 default="lhs"),
                 control = list(verbose=F))

rules.sorted = sort(rules, by="lift")

inspect(rules.sorted)

subset.matrix = is.subset(rules.sorted, rules.sorted)
subset.matrix[lower.tri(subset.matrix, diag=T)] = NA
redundant <- colSums(subset.matrix, na.rm=T) >= 1
which(redundant)
rules.pruned = rules.sorted[!redundant]

inspect(rules.pruned)
?lower.tri
