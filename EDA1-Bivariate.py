import os #### for changing the directory
import pandas as pd ####for reading the dataframes
import seaborn as sns #### for visuvalization 
import numpy as np #### for numerics and stats
# return working directory
os.getcwd()
###changing the current directory
os.chdir("D:\\DataScience\Python\Titanic")
titanic_train = pd.read_csv("train.csv")

titanic_train.shape #### like dim function in R 
titanic_train.info() #### total info about variables like str in R
titanic_train[0:10]
#### need to convert int and object to categorial 
titanic_train['Survived'] = titanic_train['Survived'].astype('category')
titanic_train.info()
titanic_train.Pclass = titanic_train.Pclass.astype('category')
titanic_train.info()
titanic_train['Sex'] = titanic_train['Sex'].astype('category')
titanic_train['Embarked'] = titanic_train['Embarked'].astype('category')

#####explore bivariate relationships: categorical vs categorical
pd.crosstab(index = titanic_train['Survived'], columns= titanic_train['Sex'] )
pd.crosstab(titanic_train['Survived'], columns=[titanic_train['Pclass'],titanic_train['Sex'],titanic_train['Embarked']], margins = True )

#####visuvalization 
sns.factorplot(x='Survived', hue = 'Sex', data = titanic_train, kind='count', size=10)
