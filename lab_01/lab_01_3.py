#!/usr/bin/env python
# coding: utf-8

# In[21]:


import numpy as np # математические операции
import pandas as pd # операции с табличками
import statsmodels.formula.api as smf # модели 
from sklearn.linear_model import LinearRegression # линейная регрессия без статистики
import seaborn as sns # графики
import matplotlib.pyplot as plt # графики


# In[ ]:


get_ipython().system('pip install rdatasets # наборы данных')
from rdatasets import data 


# In[23]:


swiss = data('swiss')


# In[24]:


swiss.head()


# In[25]:


sns.histplot(data=swiss, x='Catholic')


# In[26]:


mod_0 = smf.ols('Fertility ~ Agriculture + Catholic + Education', data=swiss)
fit_0 = mod_0.fit()


# In[27]:


fit_0.summary()


# In[28]:


new = pd.DataFrame({'Agriculture': [50], 'Catholic': [50], 'Education': [20]})
new


# In[29]:


fit_0.predict(new)


# In[30]:


new['y_hat'] = fit_0.predict(new)
new


# In[31]:


swiss['y_hat'] = fit_0.predict(swiss)


# In[32]:


swiss.head()


# In[33]:


swiss[['Fertility', 'y_hat']].corr()


# In[ ]:




