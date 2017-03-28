import numpy as np
import pandas as pd
coin_toses = np.random.randint(0,2,10000) ###0=head or tail, 2=number of possibilitiers, 10000= number of times 
pd.crosstab(index = coin_toses,columns = 'count') ### for counting purpose

dies_throw = np.random.randint(1,7,10000) ###1=min number, 7=number of possibilitiers, 10000= number of times 
pd.crosstab(index = dies_throw,columns = 'count') ### for counting purpose
           

def bayes(prior, likelyhood, evidence):
    return(prior, likelyhood,evidence) 

bayes(0.9, )