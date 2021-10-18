#!/usr/bin/env python
# coding: utf-8

# In[42]:


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

get_ipython().system('pip install linearmodels # IV')
from linearmodels.iv import IV2SLS


# In[43]:


cig = pd.read_csv('https://github.com/vincentarelbundock/Rdatasets/raw/master/csv/AER/CigarettesSW.csv')
cig.head()


# In[44]:


cig['rprice'] = cig['price'] / cig['cpi']
cig['rincome'] = cig['income'] / cig['cpi'] / cig['population']
cig['tdiff'] = cig['taxs'] - cig['tax']
cig['log_rprice'] = np.log(cig['rprice'])
cig['log_packs'] = np.log(cig['packs'])


# In[45]:


c95 = cig[cig['year'] == 1995]
c95.head()


# In[46]:


sns.relplot(data=c95, x='rprice', y='packs');


# In[47]:


# наивная модель
naive = smf.ols('log_packs ~ log_rprice', c95).fit()
naive.summary()


# In[48]:


# 2OLS руками
stage_1 = smf.ols('log_rprice ~ tdiff', c95).fit()
stage_1.summary()


# In[49]:


c95['log_rprice_hat'] = stage_1.fittedvalues


# In[50]:


c95.head()


# In[51]:


stage_2 = smf.ols('log_packs ~ log_rprice_hat', c95).fit()
stage_2.summary()


# In[60]:


# dependent ~ exog regressors + [endog regressors ~ instruments]
# указываем 1
formula = 'log_packs ~ 1 + [log_rprice ~ tdiff]'
iv_a = IV2SLS.from_formula(formula, c95).fit(cov_type='unadjusted')
iv_a


# In[61]:


iv_b = IV2SLS.from_formula(formula, c95).fit(cov_type='robust')
iv_b


# In[ ]:


formula = 'log_packs ~ 1 + rincome + [log_rprice ~ tdiff]'

