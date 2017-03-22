setwd("d:\\csv\\credit.csv")
a=read.csv("credit.csv")
head(a)
input <- a[1:10, 1:10]
input
output <- a[1:2, c(1,10,17)]
output

str(credit)

##getwd("d:\\csv\\churn.csv")
setwd("d:\\DataScience")
##setwd("d:\\csv\\churn.csv")
churn_data=read.csv("churn.csv")
head(churn_data)


# Definition of vectors
name <- c("Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune")
type <- c("Terrestrial planet", "Terrestrial planet", "Terrestrial planet", 
          "Terrestrial planet", "Gas giant", "Gas giant", "Gas giant", "Gas giant")
diameter <- c(0.382, 0.949, 1, 0.532, 11.209, 9.449, 4.007, 3.883)
rotation <- c(58.64, -243.02, 1, 1.03, 0.41, 0.43, -0.72, 0.67)
rings <- c(FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE)

# Create a data frame from the vectors
planets_df <- data.frame(name, type, diameter, rotation, rings)
planets_df
head(planets_df)
tail(planets_df)
str(planets_df)
#print 4th row
my_df1 <- planets_df[4, ]
my_df1

my_df2 <- planets_df[1:5, "diameter"]
my_df2

planets_df1 <- planets_df[1:5, 1:2]
planets_df1
planets_df1 <- read.csv("planet.csv", header = TRUE, sep = ",")
planets_df1

View(planets_df)
save.image(file = "planet_df.csv")