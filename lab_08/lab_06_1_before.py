#!/usr/bin/env python
# coding: utf-8

# In[2]:


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


# In[ ]:


get_ipython().system('pip install rdatasets # наборы данных')
get_ipython().system('pip install yfinance')
# !pip install pca
# !pip install pyreadstat # чтение spss/stata данных
from rdatasets import data 
# from pca import pca
# from pyreadstat import read_sav, set_value_labels
get_ipython().system('pip install sktime')
import yfinance as yf


# In[76]:


url = 'http://sophist.hse.ru/hse/1/tables/POPNUM_Y.htm'


# In[77]:


results = pd.read_html(url)


# In[79]:


popul = results[0]
popul.head()


# In[80]:


popul.columns = popul.loc[0, ]
popul.head()


# In[81]:


popul = popul.tail(-2)


# In[84]:


popul = popul.head(-4)


# In[85]:


popul.tail()


# In[86]:


popul.dtypes


# In[87]:


for col in ['T', 'POPNUM_Y']:
  popul[col] = pd.to_numeric(popul[col], errors='coerce')


# In[88]:


popul.describe().transpose()


# In[89]:


sns.lineplot(data=popul, x='T', y='POPNUM_Y');


# In[90]:


aapl = yf.download('AAPL', start='2020-01-01', end='2021-01-01')


# In[91]:


aapl.head()


# In[101]:


dates = pd.date_range(start='2020-01-01', end='2021-06-01', freq='QS')


# In[102]:


dates


# In[104]:


dates.to_period('Q')


# In[ ]:




