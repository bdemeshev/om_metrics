#!/usr/bin/env python
# coding: utf-8

# In[25]:


import numpy as np # математические операции
import pandas as pd # операции с табличками
import statsmodels.api as sm # модели 
import statsmodels.formula.api as smf # модели 
from sklearn.linear_model import LinearRegression # линейная регрессия без статистики
import seaborn as sns # графики
import matplotlib.pyplot as plt # графики
from statsmodels.iolib.summary2 import summary_col # несколько моделей в одной таблице
from statsmodels.graphics.mosaicplot import mosaic

from sklearn.model_selection import train_test_split
from sklearn.model_selection import cross_val_score
from sklearn.metrics import mean_squared_error
from sklearn import metrics
from sklearn.model_selection import KFold


# In[ ]:


get_ipython().system('pip install rdatasets # наборы данных')
# !pip install yfinance
from rdatasets import data 


# In[26]:


f = pd.read_csv('flats_moscow.txt', sep='\t')
f.head()


# In[27]:


f['log_price'] = np.log(f['price'])
f['log_totsp'] = np.log(f['totsp'])
f['log_kitsp'] = np.log(f['kitsp'])
f['log_livesp'] = np.log(f['livesp'])
f['remsp'] = f['totsp'] - f['livesp'] - f['kitsp']
f['log_remsp'] = np.log(f['remsp'])


# In[36]:


y = f['log_price']
Xa = f[['log_totsp']]
Xb = f[['log_livesp', 'log_kitsp', 'log_remsp']]


# In[38]:


Xa_train, Xa_test, y_train, y_test = train_test_split(Xa, y, test_size=0.2, random_state=777)
Xb_train, Xb_test, y_train, y_test = train_test_split(Xb, y, test_size=0.2, random_state=777)


# In[39]:


mod_a = LinearRegression().fit(Xa_train, y_train)
mod_b = LinearRegression().fit(Xb_train, y_train)


# In[40]:


mod_a.coef_


# In[41]:


mod_b.coef_


# In[42]:


y_hat_a = mod_a.predict(Xa_test)
y_hat_b = mod_b.predict(Xb_test)


# In[43]:


mean_squared_error(y_hat_a, y_test)


# In[44]:


mean_squared_error(y_hat_b, y_test)


# In[47]:


CV = KFold(5, shuffle=True, random_state=777)
all_mse_a = cross_val_score(mod_a, Xa, y, scoring='neg_mean_squared_error', cv=CV)
np.mean(all_mse_a)


# In[48]:


all_mse_b = cross_val_score(mod_b, Xb, y, scoring='neg_mean_squared_error', cv=CV)
np.mean(all_mse_b)


# In[ ]:




