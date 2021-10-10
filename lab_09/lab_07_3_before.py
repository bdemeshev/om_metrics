#!/usr/bin/env python
# coding: utf-8

# In[1]:


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


# In[2]:


t = pd.read_csv('titanic3.csv')


# In[3]:


t = t.drop(columns='Unnamed: 0')
for col in ['pclass', 'sex', 'embarked']:
  t[col] = pd.Categorical(t[col])


# In[25]:


fit_logit = smf.logit('survived ~ sex + age + pclass + fare', data=t).fit()


# In[26]:


fit_logit.summary()


# In[27]:


hypo = 'sex[T.male] = 0, pclass[T.2nd] = 0, pclass[T.3rd] = 0'
fit_logit.wald_test(hypo)


# In[ ]:


# H_0 о трех ограничениях отвергается при alpha = 0.01


# In[28]:


fit_logit.get_margeff(at='overall').summary()


# In[29]:


fit_logit.get_margeff(at='mean').summary()


# In[ ]:




