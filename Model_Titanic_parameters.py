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

x_train = titanic_train1[['Pclass','Sex','Embarked','Fare']]
#x_train = titanic_train1[['Fare']]
y_train = titanic_train1['Survived']

dt_estimator = tree.DecisionTreeClassifier()
#####defines the params grid as key value pair based on above tree parameters
param_grid =  {'max_depth':[3,4,5,6,7,8,9,10,11,12,13], 'min_samples_split':[2,3,4,5,6,7]}
dt_grid = model_selection.GridSearchCV(dt_estimator,param_grid, cv=10, n_jobs = 5) ###n_jobs number of threads will be open
dt_grid.fit(x_train, y_train)
#####model deployement or import by using joblib package
#joblib.dump(dt, "dt_fit2.pkl")
dt_grid.best_params_
dt_grid.best_score_
dt_grid.grid_scores_

dot_data = io.StringIO() 
tree.export_graphviz(dt_estimator, out_file = dot_data, feature_names = x_train.columns)
graph = pydot.graph_from_dot_data(dot_data.getvalue())[0] 
graph.write_pdf("dt_grid1.pdf")

#####reading test data
##titanic_test = pd.read_csv("test.csv")
#titanic_test.shape
#titanic_test.info()
#
######handle the missing values 
####at variable level and at dataframe level
#sum(titanic_test['Age'].isnull()) ####at variable level count
#titanic_test.apply(lambda x : sum(x.isnull()))
#titanic_test.Age[titanic_test['Age'].isnull()] = titanic_test['Age'].mean()
#titanic_test.Fare[titanic_test['Fare'].isnull()] = titanic_test['Fare'].mean()
####type casting means conversion of object variables to categorical variables.
####if we look at data type of Sex , as off now it is an object or sometimes it is int also, 
###it should be converted to categorical variable 
#titanic_test['Sex'] = titanic_test['Sex'].astype('category')
####we can check with info() method weather sex changed to categorical or not
#titanic_test.info()  
#####like this change all categorical variables
#titanic_test['Pclass'] = titanic_test['Pclass'].astype('category')
#titanic_test['Embarked'] = titanic_test['Embarked'].astype('category')
#
######Lebel Encoding , all input categorical variables should be converted to 
######numerics coz decision tree algorithm can not understand the categorical variables
#
#titanic_test1 = titanic_test.copy()
###le = preprocessing.LabelEncoder() ### le is label  encoder already created in train we can use this le
#titanic_test1.Pclass = le.fit_transform(titanic_test1.Pclass)
#titanic_test1.Sex = le.fit_transform(titanic_test1.Sex)
#titanic_test1.Embarked = le.fit_transform(titanic_test1.Embarked)
#
#x_test = titanic_test1[['Pclass','Sex','Embarked','Fare']]
##x_train = titanic_train1[['Fare']]
#
#dt = joblib.load("dt_fit2.pkl")
#titanic_test1['Survived'] = dt.predict(x_test)
#
#titanic_test1.to_csv("submission.csv", columns=['PassengerId','Survived'], index=False)



                       




