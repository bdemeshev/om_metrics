#!/usr/bin/env python
# coding: utf-8

# In[21]:


import numpy as np # математические операции
import pandas as pd # операции с табличками
import statsmodels.formula.api as smf # модели 
from sklearn.linear_model import LinearRegression # линейная регрессия без статистики
import seaborn as sns # графики
import matplotlib.pyplot as plt # графики
from statsmodels.iolib.summary2 import summary_col # несколько моделей в одной таблице
# from sklearn.linear_model import ElasticNetCV, ElasticNet
# from sklearn.preprocessing import StandardScaler
# from sklearn.decomposition import PCA
# import glob 
# from statsmodels.stats.diagnostic import het_white, het_goldfeldquandt
# from statsmodels.stats.stattools import durbin_watson
# from statsmodels.stats.diagnostic import acorr_breusch_godfrey
from statsmodels.graphics.mosaicplot import mosaic


# In[ ]:


get_ipython().system('pip install rdatasets # наборы данных')
# !pip install yfinance
from rdatasets import data 


# In[24]:


t = pd.read_csv('titanic3.csv')


# In[25]:


t.head()


# In[26]:


t = t.drop(columns='Unnamed: 0')


# In[27]:


for col in ['sex', 'pclass', 'survived', 'embarked']:
  t[col] = pd.Categorical(t[col])


# In[28]:


t.describe().transpose()


# In[30]:


t.describe(include='category').transpose()


# In[35]:


mosaic(t, ['pclass', 'sex', 'survived']);


# In[36]:


sns.violinplot(data=t, x='survived', y='age');


# In[37]:


sns.boxplot(data=t, x='survived', y='age');


# In[38]:


sns.displot(data=t, x='age', kind='kde', hue='survived', multiple='stack');


# In[39]:


sns.displot(data=t, x='age', kind='kde', hue='survived', multiple='fill');


# In[ ]:




