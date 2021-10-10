#!/usr/bin/env python
# coding: utf-8

# In[83]:


import numpy as np # математические операции
import pandas as pd # операции с табличками
import statsmodels.api as sm # модели 
import statsmodels.formula.api as smf # модели 
from sklearn.linear_model import LinearRegression # линейная регрессия без статистики
import seaborn as sns # графики
import matplotlib.pyplot as plt # графики
from statsmodels.iolib.summary2 import summary_col # несколько моделей в одной таблице
from statsmodels.graphics.mosaicplot import mosaic

from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import plot_precision_recall_curve
from sklearn.metrics import plot_roc_curve
from sklearn.metrics import plot_confusion_matrix, confusion_matrix


# In[ ]:


get_ipython().system('pip install rdatasets # наборы данных')
# !pip install yfinance
from rdatasets import data 


# In[84]:


t = pd.read_csv('titanic3.csv')


# In[85]:


t = t.drop(columns='Unnamed: 0')
for col in ['pclass', 'sex', 'embarked']:
  t[col] = pd.Categorical(t[col])


# In[86]:


fit_logit = smf.logit('survived ~ sex + age + pclass + fare', data=t_train).fit()
fit_logit.summary()


# In[87]:


dummies = pd.get_dummies(t[['sex', 'pclass']])
dummies.head()


# In[88]:


t_full = pd.concat([t, dummies], axis=1)
t_full.head()


# In[89]:


t_full = t_full.dropna(subset=['age', 'sex_male', 'fare', 'pclass_2nd', 'pclass_3rd', 'survived'])


# In[90]:


X = t_full[['age', 'sex_male', 'fare', 'pclass_2nd', 'pclass_3rd']]
y = t_full['survived']


# In[91]:


X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=777)


# In[92]:


sk_logit = LogisticRegression(penalty='none').fit(X_train, y_train)


# In[93]:


sk_logit.coef_


# In[94]:


sk_logit.intercept_


# In[96]:


prob_pred = sk_logit.predict_proba(X_test)
prob_pred = prob_pred[:, 1]


# In[ ]:


prob_pred


# In[99]:


confusion_matrix(y_test, prob_pred > 0.3)


# In[100]:


sns.heatmap(confusion_matrix(y_test, prob_pred > 0.4), annot=True, fmt='d', cmap='Blues')


# In[101]:


plot_roc_curve(sk_logit, X_test, y_test);


# In[ ]:


# x: FPR = FP / (FP + TN) = FP / condition Negative
# Специфичность = 1 - FPR
# y: TPR = TP / (TP + FN) = TP / condition Positive
# Чувствительность = TPR


# In[102]:


plot_precision_recall_curve(sk_logit, X_test, y_test);


# In[ ]:


# Recall = TPR = TP / condition Positive
# precision = TP / predicted Positive

