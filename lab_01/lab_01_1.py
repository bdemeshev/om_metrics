#!/usr/bin/env python
# coding: utf-8

# In[60]:


import numpy as np # математические операции
import pandas as pd # операции с табличками
import statsmodels.api as sm # модели 
import seaborn as sns # графики
import matplotlib.pyplot as plt # графики


# In[41]:


get_ipython().system('pip install rdatasets # наборы данных')
from rdatasets import data 


# In[42]:


x = [5, 7, np.nan]


# In[43]:


x


# In[44]:


np.mean(x)


# In[45]:


np.nanmean(x)


# In[46]:


h = data('cars')


# In[47]:


h.head()


# In[48]:


h.tail()


# In[49]:


h.describe()


# In[50]:


h.describe().transpose()


# In[51]:


h.shape


# In[52]:


h.columns


# In[54]:


h['speed']


# In[55]:


h.loc[4:6, 'dist']


# In[56]:


sns.relplot(data=h, x='speed', y='dist')


# In[57]:


sns.relplot(data=h, x='speed', y='dist')
plt.xlabel('Скорость машины (миль в час)')
plt.ylabel('Длина тормозного пути (футов)')
plt.title('Зависимость длины тормозного пути от скорости (данные 1920-х)')


# In[58]:


mydata = pd.DataFrame({'abc': [5, 6, np.nan], 'xyz': [-7, 5, 18]})


# In[59]:


mydata


# In[ ]:


model = sm.

