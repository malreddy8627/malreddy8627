import os
import pandas as pd
#pd. it will give us all the functions which are in pd package
#returns current working directory
os.getcwd()
#changes working directory
os.chdir("D:\\DataScience\\Python\\Titanic")

titanic_train = pd.read_csv("train.csv")
type(titanic_train)

#EDA
titanic_train.shape
titanic_train.info()
#is.na(titanic_train)
#titanic_train.describe()
#titanic_train['Survived'].value_counts()
titanic_train.groupby('Survived').size()

titanic_train.groupby(['Sex','Survived']).size()

titanic_test = pd.read_csv("test.csv")


titanic_test.shape
titanic_test.info()
titanic_test['Survived'] = 0 #### creating new column Survived and assign 0
titanic_test.Survived[titanic_test.Sex == "female"] = 1 ####like if else condition
titanic_test.Survived
titanic_test.to_csv("submission.csv", columns=['PassengerId','Survived'], index=False)
