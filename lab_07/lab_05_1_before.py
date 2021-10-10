#!/usr/bin/env python
# coding: utf-8

# In[10]:


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
import glob # list of files


# In[ ]:


get_ipython().system('pip install rdatasets # наборы данных')
# !pip install pca
# !pip install pyreadstat # чтение spss/stata данных
from rdatasets import data 
# from pca import pca
# from pyreadstat import read_sav, set_value_labels


# In[1]:


def sq(x):
  answer = x * x
  return answer


# In[2]:


sq(34)


# In[8]:


def sq_more(x, power=2):
  """Calculates square (or higher power) of the argument

  Demo function :)

  Parameters
  ----------
  x : float
    number to square
  power : non-negative float, optional
    power

  Returns
  -------
  float
    x raised to the power
  """

  if power < 0:
    raise ValueError('The value of power should be non-negative bro!')

  answer = x ** power
  return answer


# In[4]:


sq_more(34)


# In[5]:


sq_more(34, power=5)


# In[7]:


sq_more(34, -3)


# In[ ]:




