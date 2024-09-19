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

