#!/usr/bin/env python
# coding: utf-8

# In[2]:


import numpy as np # математические операции
import pandas as pd # операции с табличками
import statsmodels.formula.api as smf # модели 
from sklearn.linear_model import LinearRegression # линейная регрессия без статистики
import seaborn as sns # графики
import matplotlib.pyplot as plt # графики


# In[ ]:


get_ipython().system('pip install rdatasets # наборы данных')
from rdatasets import data 


# In[4]:


swiss = data('swiss')


# In[6]:


model = smf.ols('Fertility ~ Agriculture + Education + Catholic', data=swiss)
fit = model.fit()


# In[7]:


fit.summary()


# In[12]:


fit_summary = fit.summary()


# In[55]:


coef_info = pd.DataFrame(fit_summary.tables[1].data)
coef_info


# In[56]:


coef_info = coef_info.drop(0)


# In[57]:


coef_info.columns = ['coef', 'value', 'std', 't_stat', 'p_value', 'left_ci', 'right_ci']


# In[58]:


coef_info


# In[59]:


coef_info.dtypes


# In[60]:


for col in ['value', 'std', 't_stat', 'p_value', 'left_ci', 'right_ci']:
  coef_info[col] = pd.to_numeric(coef_info[col])


# In[61]:


coef_info.dtypes


# In[62]:


coef_info['width'] = coef_info['right_ci'] - coef_info['left_ci']


# In[63]:


coef_info


# In[67]:


coef_info.to_csv('coef_table.csv', index=False)


# In[68]:


coef_info2 = pd.read_csv('coef_table.csv')


# In[69]:


coef_info2


# In[70]:


coef_info_wi = coef_info[coef_info['coef'] != 'Intercept']


# In[71]:


coef_info_wi


# In[72]:


coef_info_wi.plot(x='coef', y='value', kind='bar', yerr='width')


# In[73]:


coef_info_wi.plot(x='coef', y='value', kind='bar', yerr='width', color='none', legend=False)


# In[ ]:




