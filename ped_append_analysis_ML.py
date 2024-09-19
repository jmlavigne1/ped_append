# -*- coding: utf-8 -*-
"""
Created on Wed Sep 18 20:28:49 2024

@author: Joseph LaVigne
"""

from ucimlrepo import fetch_ucirepo 
  
# fetch dataset 
regensburg_pediatric_appendicitis = fetch_ucirepo(id=938) 
  
# data (as pandas dataframes) 
X = regensburg_pediatric_appendicitis.data.features 
y = regensburg_pediatric_appendicitis.data.targets 
  
# metadata 
print(regensburg_pediatric_appendicitis.metadata) 
  
# variable information 
print(regensburg_pediatric_appendicitis.variables) 


ped_append = X
print(ped_append)

#prepare EDA

import seaborn as sns
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

#sns.pairplot(ped_append)
#plt.show()
#plt.clf()

# 
plt.scatter(ped_append["Segmented_Neutrophils"], ped_append["WBC_Count"])
plt.show()

sn = pd.array(ped_append["Segmented_Neutrophils"])
sn = sn.reshape(-1,1)
wbc = pd.array(ped_append["WBC_Count"])
wbc = wbc.reshape(-1,1)

# produce a simple linear regression model for ML prediction

from sklearn.linear_model import LinearRegression

line_fitter = LinearRegression()

line_fitter.fit(sn, wbc)

# the line fitter model will not work because there missing data, therefore, I will need to clean the data.
# cleaning the data
print(ped_append.dtypes)
print(ped_append["Segmented_Neutrophils"].isna().sum())
print(ped_append.count())
# 54 

