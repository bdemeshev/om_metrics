#!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np # математические операции
import pandas as pd # операции с табличками
import statsmodels.formula.api as smf # модели 
from sklearn.linear_model import LinearRegression # линейная регрессия без статистики
import seaborn as sns # графики
import matplotlib.pyplot as plt # графики
from scipy import stats # про случайные величины


# In[10]:


# Z ~ N(5, 10^2) 200 values
np.random.seed(777)
z = np.random.normal(loc=5, scale=10, size=200)


# In[11]:


sns.histplot(z)


# In[12]:


z[10:19]


# In[13]:


# Z ~ N(0; 1)
# P(Z < 0.42), P(Z > 0.42), P(|Z| > 0.42)
stats.norm.cdf(0.42)


# In[14]:


stats.norm(loc=0, scale=2).cdf(0.42)


# In[15]:


1 - stats.norm(loc=0, scale=1).cdf(0.42)


# In[16]:


2 * (1 - stats.norm(loc=0, scale=1).cdf(0.42))


# In[ ]:


# a? P(Z < a) = 0.15, Z ~ N(0;1)


# In[17]:


stats.norm(loc=0, scale=1).ppf(0.15)


# In[18]:


# R ~ t_7
# P(R < 1.5), P(R > 1.5)
stats.t(df=7).cdf(1.5)


# In[19]:


1 - stats.t(df=7).cdf(1.5)


# In[20]:


# a? P(R < a) = 0.15 if R ~ t_7
stats.t(df=7).ppf(0.15)


# In[21]:


stats.norm(loc=6, scale=7).var()


# In[23]:


stats.t(df=7).interval(alpha=0.95)


# In[ ]:




