#!/usr/bin/env python
# coding: utf-8

# In[ ]:


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


# In[16]:


cars = data('cars')


# In[17]:


sns.relplot(data=cars, x='speed', y='dist')


# In[18]:


cars['speed2'] = cars['speed'] ** 2
cars['speed3'] = cars['speed'] ** 3


# In[19]:


corr_mat = cars.corr()
corr_mat


# In[21]:


sns.heatmap(corr_mat);


# In[22]:


fit_1 = smf.ols('dist ~ speed', data=cars).fit()
fit_2 = smf.ols('dist ~ speed + speed2 + speed3', data=cars).fit()


# In[23]:


fit_1.summary()


# In[24]:


fit_2.summary()


# In[26]:


fit_2.compare_f_test(fit_1)


# In[27]:


new = pd.DataFrame({'speed': [10], 'speed2': [100], 'speed3': [1000]})
new


# In[28]:


fit_1.get_prediction(new).summary_frame(alpha=0.99)


# In[29]:


fit_2.get_prediction(new).summary_frame(alpha=0.99)


# In[31]:


sns.clustermap(cars, standard_scale=1);


# In[32]:


from statsmodels.stats.outliers_influence import variance_inflation_factor


# In[33]:


X = cars.drop(columns='dist')


# In[34]:


X.head()


# In[35]:


X['ones'] = 1


# In[36]:


X.head()


# In[42]:


vifs = [variance_inflation_factor(X.values, i) for i in [0, 1, 2]]
vifs


# In[ ]:




