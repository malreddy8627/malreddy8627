import pandas as pd

col1 = [10,20,30,40,60,70]
col1
col2 = ['abc','def','xyz','pqr', 'rtc', 'ert']
col2
col3 = [0,0,0,0,0,0]

#creating data frame
df1 = pd.DataFrame({'pid':col1,
'pname':col2,'survived':col3})
df1
df1.shape #### will get dimentions like rows and columns
df1.info()
df1.describe()
df1.head(2)
df1.tail()

df1['col4'] = 0

#access frame content by column/columns
df1.pid
df1['pid']
df1[['pid','pname']]
df1[[0,1]]

#df1.all
#dropping a column
df2 = df1.drop('survived','col4',1)
df2
#slicing rows of frame
df1[0:2]
df1[0:4]
df1[0:]
df1[:2]
df1[-3:]

#filtering rows of dataframe by condition
type(df1.pid > 20)
df3=df1[df1.pid>20]
df3
#selecting subsets of rows and columns
df1.iloc[0:2,]
df1.iloc[[0,2,3],]
df1.iloc[0:2,0]
df1.iloc[0:2,[0,2]]
df1.loc[0:2,['pname']]

#grouping data in data frames
df1.groupby('id').size()