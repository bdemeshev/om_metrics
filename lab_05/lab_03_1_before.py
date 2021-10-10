#!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np # математические операции
import pandas as pd # операции с табличками
import statsmodels.formula.api as smf # модели 
from sklearn.linear_model import LinearRegression # линейная регрессия без статистики
import seaborn as sns # графики
import matplotlib.pyplot as plt # графики


# In[ ]:


get_ipython().system('pip install rdatasets # наборы данных')
# !pip install pyreadstat # чтение spss/stata данных
from rdatasets import data 
# from pyreadstat import read_sav, set_value_labels


# In[14]:


flats = pd.read_csv('flats_moscow.txt', sep='\t')


# In[15]:


flats.head()


# In[16]:


for col in ['walk', 'brick', 'floor', 'code']:
  flats[col] = pd.Categorical(flats[col])


# In[20]:


sns.catplot(data=flats, x='walk', kind='count');


# In[22]:


sns.histplot(data=flats, x='livesp');


# In[24]:


sns.relplot(data=flats, x='totsp', y='price', hue='walk');


# In[26]:


sns.catplot(data=flats, 
            y='price',
            x='walk',
            kind='violin')


# In[27]:


sns.histplot(data=flats, x='price', hue='floor')


# In[28]:


sns.histplot(data=flats, x='price', hue='floor', multiple='stack');


# In[29]:


from statsmodels.graphics.mosaicplot import mosaic


# In[31]:


mosaic(flats, ['walk']);


# In[32]:


mosaic(flats, ['walk', 'brick']);


# In[33]:


mosaic(flats, ['walk', 'brick', 'floor']);


# In[ ]:




