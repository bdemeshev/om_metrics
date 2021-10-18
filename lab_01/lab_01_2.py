#!/usr/bin/env python
# coding: utf-8

# In[25]:


import numpy as np # математические операции
import pandas as pd # операции с табличками
import statsmodels.formula.api as smf # модели 
from sklearn.linear_model import LinearRegression # линейная регрессия без статистики
import seaborn as sns # графики
import matplotlib.pyplot as plt # графики


# In[26]:


get_ipython().system('pip install rdatasets # наборы данных')
from rdatasets import data 


# In[27]:


h = data('cars')


# In[28]:


h.head()


# In[29]:


model_0 = smf.ols('dist ~ speed', data=h)
fit_0 = model_0.fit()


# In[30]:


fit_0.summary()


# In[31]:


fit_0.params


# In[37]:


fit_0.rsquared


# In[38]:


fit_0.resid


# In[39]:


fit_0.ssr


# In[40]:


new = pd.DataFrame({'speed': [10, 60]})


# In[41]:


new


# In[42]:


fit_0.predict(new)


# In[50]:


y = h['dist']
X = h[['speed']]


# In[51]:


sk_mod_0 = LinearRegression()
sk_fit_0 = sk_mod_0.fit(X, y)


# In[52]:


sk_fit_0.coef_


# In[53]:


sk_fit_0.intercept_


# In[57]:


sk_fit_0.predict(new)


# In[64]:


h['speed2'] = h['speed'] ** 2


# In[62]:


model_1 = smf.ols('dist ~ speed + speed2', data=h)
fit_1 = model_1.fit()


# In[63]:


fit_1.summary()


# In[ ]:




