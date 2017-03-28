import os
import pandas as pd #for data frames
from sklearn import tree #tree is the sub package from sklearn for classification problem
from sklearn import preprocessing #for label encoding , for scaling and for normalization
import pydot 
from sklearn import ensemble
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
#adaptive boosting
adaboost_estimator = ensemble.AdaBoostClassifier(n_estimators = 5,random_state = 10)
scores = model_selection.cross_val_score(adaboost_estimator, x_train, y_train, cv =10,)
scores.mean()
adaboost_estimator.fit(x_train, y_train)
adaboost_estimator.estimator_weights_
adaboost_estimator.estimator_errors_

#####random forest trees pdf
rf_trees = rf_estimator.estimators_[0].tree_

dot_data = io.StringIO() 
tree.export_graphviz(rf_trees, out_file = dot_data, feature_names = x_train.columns)
graph = pydot.graph_from_dot_data(dot_data.getvalue())[0] 
graph.write_pdf("rf0.pdf")

#CV-evalaution is done for each combination of parameters
#Final model is built based on best parameterd discovered in the process
rf_estimator1 = ensemble.RandomForestClassifier(oob_score=True)
param_grid = {'n_estimators':[100,200,500,1000], 'max_features':[2,3,4]}
grid_model = model_selection.GridSearchCV(rf_estimator1, param_grid, cv=10, n_jobs=4)
grid_model.fit(x_train, y_train)
grid_model.grid_scores_
grid_model.best_params_

rf_estimator.oob_score_

dot_data = io.StringIO() 
tree.export_graphviz(dt, out_file = dot_data, feature_names = x_train.columns)
graph = pydot.graph_from_dot_data(dot_data.getvalue())[0] 
graph.write_pdf("dt2.pdf")


#####reading test data
titanic_test = pd.read_csv("test.csv")
titanic_test.shape
titanic_test.info()
#
######handle the missing values 
####at variable level and at dataframe level
sum(titanic_test['Age'].isnull()) ####at variable level count
titanic_test.apply(lambda x : sum(x.isnull()))
titanic_test.Age[titanic_test['Age'].isnull()] = titanic_test['Age'].mean()
titanic_test.Fare[titanic_test['Fare'].isnull()] = titanic_test['Fare'].mean()
####type casting means conversion of object variables to categorical variables.
####if we look at data type of Sex , as off now it is an object or sometimes it is int also, 
###it should be converted to categorical variable 
titanic_test['Sex'] = titanic_test['Sex'].astype('category')
####we can check with info() method weather sex changed to categorical or not
titanic_test.info()  
#####like this change all categorical variables
titanic_test['Pclass'] = titanic_test['Pclass'].astype('category')
titanic_test['Embarked'] = titanic_test['Embarked'].astype('category')
#
######Lebel Encoding , all input categorical variables should be converted to 
######numerics coz decision tree algorithm can not understand the categorical variables
#
titanic_test1 = titanic_test.copy()
le = preprocessing.LabelEncoder() ### le is label  encoder already created in train we can use this le
titanic_test1.Pclass = le.fit_transform(titanic_test1.Pclass)
titanic_test1.Sex = le.fit_transform(titanic_test1.Sex)
titanic_test1.Embarked = le.fit_transform(titanic_test1.Embarked)
#
x_test = titanic_test1[['Pclass','Sex','Embarked','Fare']]
##x_train = titanic_train1[['Fare']]
#
#dt = joblib.load("dt_fit2.pkl")
titanic_test1['Survived'] = grid_model.predict(x_test)
#
titanic_test1.to_csv("submission.csv", columns=['PassengerId','Survived'], index=False)



                       




