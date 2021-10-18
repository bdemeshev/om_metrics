#!/usr/bin/env python
# coding: utf-8

# In[9]:


import numpy as np # математические операции
import pandas as pd # операции с табличками
import statsmodels.api as sm # модели 
import statsmodels.formula.api as smf # модели 
from sklearn.linear_model import LinearRegression # линейная регрессия без статистики
from sklearn.ensemble import RandomForestRegressor
import seaborn as sns # графики
import matplotlib.pyplot as plt # графики
from statsmodels.iolib.summary2 import summary_col # несколько моделей в одной таблице

from sklearn.metrics import mean_squared_error
from sklearn.model_selection import train_test_split


# In[10]:


f = pd.read_csv('flats_moscow.txt', sep='\t')
f.head()


# In[12]:


f['remsp'] = f['totsp'] - f['livesp'] - f['kitsp'] 
f['log_remsp'] = np.log(f['remsp'])
f['log_totsp'] = np.log(f['totsp'])
f['log_kitsp'] = np.log(f['kitsp'])
f['log_livesp'] = np.log(f['livesp'])
f['log_price'] = np.log(f['price'])


# In[31]:


X = f[['log_livesp', 'log_kitsp', 'log_remsp']]
y = f['log_price']


# In[32]:


X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, random_state=777)


# In[33]:


linreg = LinearRegression()
linreg_fit = linreg.fit(X_train, y_train)


# In[34]:


linreg_fit.coef_


# In[35]:


linreg_fit.intercept_


# In[36]:


random_forest = RandomForestRegressor(n_estimators=5000, random_state=777)
random_forest_fit = random_forest.fit(X_train, y_train)


# In[37]:


y_hat_linreg = linreg_fit.predict(X_test)
y_hat_random_forest = random_forest_fit.predict(X_test)


# In[38]:


y_test


# In[39]:


mean_squared_error(y_test, y_hat_linreg)


# In[40]:


mean_squared_error(y_test, y_hat_random_forest)


# In[ ]:




