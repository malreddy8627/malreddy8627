import os #### for changing the directory
import pandas as pd ####for reading the dataframes
# return working directory
os.getcwd()
###changing the current directory
os.chdir("D:\\DataScience\Python\Titanic")
titanic_train = pd.read_csv("train.csv")

titanic_train.shape #### like dim function in R 
titanic_train.info() #### total info about variables like str in R
titanic_train[]

