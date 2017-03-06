import os #### for changing the directory
import pandas as pd ####for reading the dataframes
import seaborn as sns #### for visuvalization 
import numpy as np #### for numerics and stats

os.getcwd()
###changing the current directory
os.chdir("D:\\DataScience\Python")
rain = pd.read_csv("Rainfall.csv", header = None, sep = "\s+")
rain.shape
rain.info()
rain.columns # for columns names
rain.iloc[0:1,[3]]
#df1.loc[0:2,['pname']]
rain.iloc[0:1,]
rain.Daily = rain.sum(axis=3)

