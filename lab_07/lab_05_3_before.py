#!/usr/bin/env python
# coding: utf-8

# In[41]:


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
from statsmodels.stats.diagnostic import het_white, het_goldfeldquandt


# In[ ]:


get_ipython().system('pip install rdatasets # наборы данных')
# !pip install pca
# !pip install pyreadstat # чтение spss/stata данных
from rdatasets import data 
# from pca import pca
# from pyreadstat import read_sav, set_value_labels


# In[50]:


flats = pd.read_csv('flats_moscow.txt', sep='\t')


# In[51]:


flats.head()


# In[53]:


sns.relplot(data=flats, x='totsp', y='price');


# In[54]:


flats['ln_totsp'] = np.log(flats['totsp'])
flats['ln_price'] = np.log(flats['price'])


# In[55]:


sns.relplot(data=flats, x='ln_totsp', y='ln_price');


# In[56]:


fit_naive = smf.ols('price ~ totsp', data=flats).fit()


# In[57]:


fit_naive.summary()


# In[59]:


fit_hc = smf.ols('price ~ totsp', data=flats).fit(cov_type='HC1')


# In[60]:


fit_hc.summary()


# In[61]:


# nonrobust covariance matrix estimate
fit_naive.cov_params()


# In[62]:


fit_hc.cov_params()


# In[63]:


fit_naive.cov_HC1


# In[64]:


summary_col([fit_naive, fit_hc])


# In[65]:


fit_naive.conf_int()


# In[66]:


fit_hc.conf_int()


# In[67]:


fit_naive.resid


# In[68]:


fit_naive.model.exog


# In[69]:


fit_naive.model.endog


# In[70]:


# White test
het_white(fit_naive.resid, fit_naive.model.exog)


# In[ ]:


# p_value < alpha = 0.01
# H_0 is rejected


# In[71]:


het_goldfeldquandt(y=fit_naive.model.endog,
                   x=fit_naive.model.exog,
                   idx=1,
                   drop=0.2,
                   alternative='increasing')


# In[ ]:


# p_value < alpha = 0.01
# H_0 is rejected

