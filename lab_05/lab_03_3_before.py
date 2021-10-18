#!/usr/bin/env python
# coding: utf-8

# In[24]:


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


# In[26]:


flats = pd.read_csv('flats_moscow.txt', sep='\t')


# In[27]:


for col in ['walk', 'brick', 'floor', 'code']:
  flats[col] = pd.Categorical(flats[col])


# In[28]:


from numpy import log

fit_1 = smf.ols('log(price) ~ log(totsp)', data=flats).fit()
fit_2 = smf.ols('log(price) ~ log(totsp) + code', data=flats).fit()
fit_3 = smf.ols('log(price) ~ log(totsp) + brick + brick:log(totsp)', data=flats).fit()


# In[29]:


fit_2.compare_f_test(fit_1)


# In[ ]:





# In[ ]:


# H_0: верна fit_1, H_a: fit_1 не верна, но верна fit_2


# In[30]:


fit_3.compare_f_test(fit_2)


# In[ ]:


# модели 3 и 2 невложенные и нельзя их сравнивать f-тестом


# In[31]:


fit_3.compare_f_test(fit_1)


# In[ ]:


# H_0: верна fit_1, H_a: fit_1 не верна, но верна fit_3
# H_0 отвергается


# In[33]:


# RESET тест Рамсея
flats['yhat_3'] = np.exp(fit_3.fittedvalues)
flats.head()


# In[36]:


formula = 'log(price) ~ log(totsp) + brick + brick:log(totsp) + I(yhat_3 ** 2) + I(yhat_3 ** 3)'
ramsey = smf.ols(formula, data=flats).fit()


# In[37]:


ramsey.summary()


# In[40]:


ramsey.f_test('I(yhat_3 ** 2) = 0,  I(yhat_3 ** 3) = 0')


# In[ ]:


# H_0: b_2 = 0, b_3 = 0
# alpha = 1%
# H_0 отвергается


# In[41]:


ramsey.compare_f_test(fit_3)


# In[ ]:




