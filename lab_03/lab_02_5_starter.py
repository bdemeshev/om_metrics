#!/usr/bin/env python
# coding: utf-8

# In[47]:


import numpy as np # математические операции
import pandas as pd # операции с табличками
import statsmodels.formula.api as smf # модели 
from sklearn.linear_model import LinearRegression # линейная регрессия без статистики
import seaborn as sns # графики
import matplotlib.pyplot as plt # графики


# In[ ]:


get_ipython().system('pip install rdatasets # наборы данных')
get_ipython().system('pip install pyreadstat # чтение spss/stata данных')
from rdatasets import data 
from pyreadstat import read_sav, set_value_labels


# In[49]:


# рост xm2
# вес xm1
# пол xh5
# год рождения xh6
# возраст x_age


# In[50]:


attempt1 = pd.read_spss('r28i_os_32.sav')


# In[51]:


attempt1.head()


# In[57]:


data, meta = read_sav('r28i_os_32.sav', apply_value_formats=True)


# In[ ]:


meta.column_names_to_labels


# In[ ]:


meta.variable_value_labels


# In[67]:


data_sub = data[['xm1', 'xm2', 'xh5', 'xh6', 'x_age']]


# In[68]:


data_sub.head()


# In[69]:


data_sub = data_sub.rename(columns={'xm1': 'weight',
                                    'xm2': 'height',
                                    'xh5': 'sex',
                                    'xh6': 'birth_year',
                                    'x_age': 'age'})


# In[70]:


data_sub.head()


# In[71]:


for col in ['weight', 'height', 'birth_year', 'age']:
  data_sub[col] = pd.to_numeric(data_sub[col], errors='coerce')


# In[72]:


data_sub.head()


# In[74]:


data_sub.describe().transpose()


# In[76]:


sns.relplot(data=data_sub, x='height', y='weight')
plt.xlabel('Рост индивида (см)')
plt.ylabel('Вес индивида (кг)')
plt.title('Данные RLMS 28 волны по индивидам');


# In[ ]:




