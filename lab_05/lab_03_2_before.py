#!/usr/bin/env python
# coding: utf-8

# In[43]:


import numpy as np # математические операции
import pandas as pd # операции с табличками
import statsmodels.formula.api as smf # модели 
from sklearn.linear_model import LinearRegression # линейная регрессия без статистики
import seaborn as sns # графики
import matplotlib.pyplot as plt # графики
from statsmodels.iolib.summary2 import summary_col # несколько моделей в одной таблице


# In[ ]:


get_ipython().system('pip install rdatasets # наборы данных')
# !pip install pyreadstat # чтение spss/stata данных
from rdatasets import data 
# from pyreadstat import read_sav, set_value_labels


# In[45]:


flats = pd.read_csv('flats_moscow.txt', sep='\t')


# In[46]:


flats.head()


# In[47]:


for col in ['walk', 'brick', 'floor', 'code']:
  flats[col] = pd.Categorical(flats[col])


# In[49]:


sns.relplot(data=flats, x='totsp', y='price', hue='walk', col='brick')


# In[58]:


from numpy import log


# In[59]:


fit_1 = smf.ols('log(price) ~ log(totsp)', data=flats).fit()
fit_2 = smf.ols('log(price) ~ log(totsp) + code', data=flats).fit()
fit_3 = smf.ols('log(price) ~ log(totsp) + brick + brick:log(totsp)', data=flats).fit()


# In[60]:


fit_1.summary()


# In[61]:


summary_col([fit_1, fit_2, fit_3])


# In[62]:


flats['code'].unique()


# In[63]:


new = pd.DataFrame({'code': [3], 'totsp': [60], 'brick': [1]})


# In[64]:


new


# In[65]:


fit_3.predict(new)


# In[66]:


np.exp(fit_3.predict(new))


# In[69]:


fcst = fit_3.get_prediction(new).summary_frame(alpha=0.99)
fcst


# In[70]:


np.exp(fcst)


# In[ ]:




