#!/usr/bin/env python
# coding: utf-8

# In[23]:


import numpy as np # математические операции
import pandas as pd # операции с табличками
import statsmodels.formula.api as smf # модели 
from sklearn.linear_model import LinearRegression # линейная регрессия без статистики
import seaborn as sns # графики
import matplotlib.pyplot as plt # графики
from statsmodels.iolib.summary2 import summary_col # несколько моделей в одной таблице
# from sklearn.linear_model import ElasticNetCV, ElasticNet
# from sklearn.preprocessing import StandardScaler
# from sklearn.decomposition import PCA
import glob 


# In[ ]:


get_ipython().system('pip install rdatasets # наборы данных')
# !pip install pca
# !pip install pyreadstat # чтение spss/stata данных
from rdatasets import data 
# from pca import pca
# from pyreadstat import read_sav, set_value_labels


# In[31]:


np.arange(1, 12)


# In[32]:


for i in np.arange(1, 12):
  print(i)


# In[35]:


cars = data('cars')


# In[36]:


cars.head()


# In[37]:


for i in np.arange(5, 17):
  file_name = 'part_of_cars_' + str(i) + '.csv'
  part = cars.loc[0:i, ]
  part.to_csv(file_name, index=False)
  print(file_name)


# In[38]:


get_ipython().system('ls')


# In[39]:


all_files = glob.glob('part_of*.csv')


# In[40]:


all_files


# In[41]:


data_list = []
for file in all_files:
  data = pd.read_csv(file)
  data['source'] = file
  data_list.append(data)
  print(file)


# In[ ]:


data_list


# In[43]:


big_df = pd.concat(data_list)


# In[44]:


big_df.head()


# In[45]:


big_df.tail()


# In[ ]:




