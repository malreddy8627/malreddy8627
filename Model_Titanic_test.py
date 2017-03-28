import os
import pandas as pd #for data frames
from sklearn import tree #tree is the sub package from sklearn for classification problem
from sklearn import preprocessing #for label encoding , for scaling and for normalization
import pydot 
from sklearn import metrics
from sklearn import model_selection ####for cross validation or k-folds for sampling
from sklearn.externals import joblib ## for import the fit model to validate against to test data 
import io

#returns the current working directory
os.getcwd()
#change the current working directory
os.chdir("D:\\DataScience\\Python\\Titanic")
#####reading test data
titanic_test = pd.read_csv("test.csv")
titanic_test.shape
titanic_test.info()

#####handle the missing values 
###at variable level and at dataframe level
sum(titanic_test['Age'].isnull()) ####at variable level count
titanic_test.apply(lambda x : sum(x.isnull()))
titanic_test.Age[titanic_test['Age'].isnull()] = titanic_test['Age'].mean()
titanic_test.Fare[titanic_test['Fare'].isnull()] = titanic_test['Fare'].mean()
###type casting means conversion of object variables to categorical variables.
###if we look at data type of Sex , as off now it is an object or sometimes it is int also, 
##it should be converted to categorical variable 
titanic_test['Sex'] = titanic_test['Sex'].astype('category')
###we can check with info() method weather sex changed to categorical or not
titanic_test.info()  
####like this change all categorical variables
titanic_test['Pclass'] = titanic_test['Pclass'].astype('category')
titanic_test['Embarked'] = titanic_test['Embarked'].astype('category')

#####Lebel Encoding , all input categorical variables should be converted to 
#####numerics coz decision tree algorithm can not understand the categorical variables

titanic_test1 = titanic_test.copy()
##le = preprocessing.LabelEncoder() ### le is label  encoder already created in train we can use this le
le = preprocessing.LabelEncoder() ### le is label  encoder
titanic_test1.Pclass = le.fit_transform(titanic_test1.Pclass)
titanic_test1.Sex = le.fit_transform(titanic_test1.Sex)
titanic_test1.Embarked = le.fit_transform(titanic_test1.Embarked)

x_test = titanic_test1[['Pclass','Sex','Embarked','Fare']]
#x_train = titanic_train1[['Fare']]

dt = joblib.load("dt_fit2.pkl")
titanic_test1['Survived'] = dt.predict(x_test)


titanic_test1.to_csv("submission.csv", columns=['PassengerId','Survived'], index=False)



                       





