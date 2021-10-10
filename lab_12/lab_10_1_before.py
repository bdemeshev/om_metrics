#!/usr/bin/env python
# coding: utf-8

# In[34]:


import numpy as np # математические операции
import pandas as pd # операции с табличками
import statsmodels.api as sm # модели 
import statsmodels.formula.api as smf # модели 
from sklearn.linear_model import LinearRegression # линейная регрессия без статистики
import seaborn as sns # графики
import matplotlib.pyplot as plt # графики
from statsmodels.iolib.summary2 import summary_col # несколько моделей в одной таблице
from statsmodels.graphics.mosaicplot import mosaic


# In[ ]:


get_ipython().system('pip install rdatasets # наборы данных')
# !pip install yfinance
from rdatasets import data 


# In[35]:


f = pd.read_csv('flats_moscow.txt', sep='\t')
f.head()


# In[36]:


simple = smf.ols('price ~ totsp', f).fit()
simple.summary()


# In[37]:


q_01 = smf.quantreg('price ~ totsp', f).fit(q=0.1)
q_01.summary()


# In[38]:


qts = [0.1, 0.5, 0.9]
q_mods = [smf.quantreg('price ~ totsp', f).fit(q=quantile) for quantile in qts]


# In[41]:


q_mods[2].summary()


# In[72]:


res = sns.relplot(data=f, x='totsp', y='price');
x = np.arange(f['totsp'].min(), f['totsp'].max(), 1)
for q_mod in q_mods:
  y = q_mod.params[0] + q_mod.params[1] * x
  res.ax.plot(x, y, linestyle='dotted', color='blue');


# In[70]:





# In[ ]:




