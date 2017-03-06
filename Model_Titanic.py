import os
import pandas as pd #for data frames
from sklearn import tree #tree is the sub package from sklearn for classification problem
from sklearn import preprocessing #for label encoding , for scaling and for normalization
import pydot 
import io

#returns the current working directory
os.getcwd()
#change the current working directory
os.chdir("D:\\DataScience\\Python\\Titanic")
titanic_train = pd.read_csv("train.csv")

#####EDA on train dataset
titanic_train.shape 
titanic_train.columns #for getting dataframe column names
titanic_train.info()
titanic_train.describe()
titanic_train.head(20)

#####handle the missing values 
###at variable level and at dataframe level
sum(titanic_train['Age'].isnull()) ####at variable level count
titanic_train.apply(lambda x : sum(x.isnull()))
titanic_train.Age[titanic_train['Age'].isnull()] = titanic_train['Age'].mean()
titanic_train.Embarked[titanic_train['Embarked'].isnull()] = 'S'
###type casting means conversion of object variables to categorical variables.
###if we look at data type of Sex , as off now it is an object , it should be converted to
####categorical variable 
titanic_train['Sex'] = titanic_train['Sex'].astype('category')
###we can check with info() method weather sex changed to categorical or not
titanic_train.info()  
####like this change all categorical variables
titanic_train['Survived'] = titanic_train['Survived'].astype('category')
titanic_train['Pclass'] = titanic_train['Pclass'].astype('category')
titanic_train['Embarked'] = titanic_train['Embarked'].astype('category')

#####Lebel Encoding , all input categorical variables should be converted to 
#####numerics coz decision tree algorithm can not understand the categorical variables

titanic_train1 = titanic_train.copy()
le = preprocessing.LabelEncoder() ### le is label  encoder
titanic_train1.Pclass = le.fit_transform(titanic_train1.Pclass)
titanic_train1.Sex = le.fit_transform(titanic_train1.Sex)
titanic_train1.Embarked = le.fit_transform(titanic_train1.Embarked)

####one Hot Encoder , this is like dummy variables will be created
#ohe = preprocessing.OneHotEncoder()
#titanic_train1.Sex = ohe.fit_transform(titanic_train1.Sex)
#titanic_train1.Pclass = ohe.fit_transform(titanic_train1.Pclass)
#titanic_train1.Embarked = ohe.fit_transform(titanic_train1.Embarked)

#x_train = titanic_train1[['Pclass','Sex','Embarked']]
x_train = titanic_train1[['Fare']]
y_train = titanic_train1['Survived']

dt = tree.DecisionTreeClassifier()
dt_fit = dt.fit(x_train, y_train)

dot_data = io.StringIO() 
tree.export_graphviz(dt, out_file = dot_data, feature_names = x.columns)
graph = pydot.graph_from_dot_data(dot_data.getvalue())[0] 
graph.write_pdf("dt1.pdf")







                       




