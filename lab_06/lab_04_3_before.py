#!/usr/bin/env python
# coding: utf-8

# In[47]:


import numpy as np # математические операции
import pandas as pd # операции с табличками
import statsmodels.formula.api as smf # модели 
from sklearn.linear_model import LinearRegression # линейная регрессия без статистики
import seaborn as sns # графики
import matplotlib.pyplot as plt # графики
from statsmodels.iolib.summary2 import summary_col # несколько моделей в одной таблице
# from sklearn.linear_model import ElasticNetCV, ElasticNet
from sklearn.preprocessing import StandardScaler
from sklearn.decomposition import PCA


# In[ ]:


get_ipython().system('pip install rdatasets # наборы данных')
get_ipython().system('pip install pca')
from pca import pca
# !pip install pyreadstat # чтение spss/stata данных
from rdatasets import data 
# from pyreadstat import read_sav, set_value_labels


# In[60]:


h = pd.read_csv('https://github.com/vincentarelbundock/Rdatasets/raw/master/csv/HSAUR/heptathlon.csv')


# In[61]:


h.head()


# In[62]:


h = h.rename(columns={'Unnamed: 0': 'name'})
h.head()


# In[63]:


X = h.drop(columns=['name', 'score'])
X.head()


# In[64]:


X_scaled = StandardScaler().fit_transform(X)


# In[74]:


pca_sk = PCA(n_components=2).fit(X_scaled)
pca_sk_comp = PCA(n_components=2).fit_transform(X_scaled)


# In[67]:


pca_sk.components_


# In[68]:


pca_sk.explained_variance_ratio_


# In[69]:


pca_model = pca(n_components=2, normalize=True)
pca_components = pca_model.fit_transform(X)


# In[ ]:


pca_components['PC']


# In[72]:


pca_model.biplot(y=h['name']);


# In[73]:


pca_model.plot();


# In[ ]:




