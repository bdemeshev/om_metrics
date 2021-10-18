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
from statsmodels.stats.stattools import durbin_watson
from statsmodels.stats.diagnostic import acorr_breusch_godfrey


# In[ ]:


get_ipython().system('pip install rdatasets # наборы данных')
# !pip install yfinance
from rdatasets import data 
# !pip install sktime
# import yfinance as yf


# In[23]:


inv = data('sandwich', 'Investment')


# In[24]:


inv.head()


# In[25]:


inv['lag_investment'] = inv['Investment'].shift(1)
inv['diff_investment'] = inv['Investment'].diff(1)
inv.head()


# In[31]:


fit = smf.ols('RealInv ~ RealInt + RealGNP', data=inv).fit(cov_type='HAC', 
                                                            cov_kwds={'maxlags': None})


# In[32]:


fit.summary()


# In[33]:


acorr_breusch_godfrey(fit, nlags=2)


# In[34]:


durbin_watson(fit.resid)


# In[ ]:




