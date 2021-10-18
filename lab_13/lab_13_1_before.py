#!/usr/bin/env python
# coding: utf-8

# In[26]:


import numpy as np # математические операции
import pandas as pd # операции с табличками
import statsmodels.api as sm # модели 
import statsmodels.formula.api as smf # модели 
from sklearn.linear_model import LinearRegression # линейная регрессия без статистики
from sklearn.ensemble import RandomForestRegressor
import seaborn as sns # графики
import matplotlib.pyplot as plt # графики
from statsmodels.iolib.summary2 import summary_col # несколько моделей в одной таблице


# In[8]:


get_ipython().system('pip install arch')
from arch.bootstrap import IIDBootstrap
get_ipython().system('pip install rdatasets')
from rdatasets import data


# In[ ]:


d = data('cars')
speed = d['speed']
speed


# In[28]:


from numpy import median


# In[29]:


bs = IIDBootstrap(speed, seed=777)
bs.conf_int(median, reps=10000, method='basic')


# In[30]:


bs = IIDBootstrap(speed, seed=777)
bs.conf_int(median, reps=100, method='studentized')


# In[ ]:




