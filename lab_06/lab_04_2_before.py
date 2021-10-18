#!/usr/bin/env python
# coding: utf-8

# In[62]:


import numpy as np # математические операции
import pandas as pd # операции с табличками
import statsmodels.formula.api as smf # модели 
from sklearn.linear_model import LinearRegression # линейная регрессия без статистики
import seaborn as sns # графики
import matplotlib.pyplot as plt # графики
from statsmodels.iolib.summary2 import summary_col # несколько моделей в одной таблице
from sklearn.linear_model import ElasticNetCV, ElasticNet
from sklearn.preprocessing import StandardScaler


# In[ ]:


get_ipython().system('pip install rdatasets # наборы данных')
# !pip install pyreadstat # чтение spss/stata данных
from rdatasets import data 
# from pyreadstat import read_sav, set_value_labels


# In[63]:


cars = data('cars')


# In[64]:


sns.relplot(data=cars, x='speed', y='dist')


# In[65]:


cars['speed2'] = cars['speed'] ** 2
cars['speed3'] = cars['speed'] ** 3


# In[66]:


y = cars['dist']
X = cars[['speed', 'speed2', 'speed3']]


# In[67]:


X.head()


# In[68]:


X_scaled = StandardScaler().fit_transform(X, y)


# In[ ]:


X_scaled


# In[82]:


# LASSO lambda = 10
model = ElasticNet(alpha=10, l1_ratio=1, normalize=True).fit(X, y)


# In[83]:


model.alpha


# In[84]:


model.coef_


# In[85]:


model.intercept_


# In[87]:


y_hat = model.predict(X)
y_hat


# In[88]:


model.score(X, y)


# In[89]:


alphas = [0.0001, 0.001, 0.01, 0.1, 1]
models = [ElasticNet(alpha, l1_ratio=1, normalize=True).fit(X, y) for alpha in alphas]


# In[90]:


betas_hat = [model.coef_ for model in models]
betas_hat


# In[91]:


r2s = [model.score(X, y) for model in models]
r2s


# In[92]:


more_alphas = np.arange(0.000001, 1, 0.01)
fit = ElasticNetCV(l1_ratio=1, alphas=more_alphas, normalize=True, cv=10, random_state=777).fit(X, y)


# In[93]:


fit.alpha_


# In[94]:


lasso_best = ElasticNet(alpha=fit.alpha_, l1_ratio=1, normalize=True).fit(X, y)


# In[95]:


lasso_best.coef_


# In[98]:


new = [[10, 100, 1000], [20, 400, 8000]]
lasso_best.predict(new)


# In[ ]:




