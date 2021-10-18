#!/usr/bin/env python
# coding: utf-8

# In[41]:


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


# In[78]:


t = pd.read_csv('titanic3.csv')


# In[79]:


t.head()


# In[80]:


t = t.drop(columns='Unnamed: 0')


# In[81]:


for col in ['pclass', 'sex', 'embarked']:
  t[col] = pd.Categorical(t[col])


# In[82]:


t['surv_cat'] = pd.Categorical(t['survived'])


# In[ ]:


fit_wrong_logit = smf.logit('surv_cat ~ sex + age + pclass + fare', data=t).fit()


# In[84]:


fit_logit = smf.logit('survived ~ sex + age + pclass + fare', data=t).fit()


# In[85]:


fit_logit.summary()


# In[86]:


fit_probit = smf.probit('survived ~ sex + age + pclass + fare', data=t).fit()


# In[87]:


summary_col([fit_logit, fit_probit])


# In[88]:


new = pd.DataFrame({'age': np.arange(5, 100, step=0.5)})
new['fare'] = 100
new['pclass'] = '2nd'
new['sex'] = 'male'


# In[89]:


new.head()


# In[90]:


new['phat'] = fit.predict(new)
new.head()


# In[91]:


logit = sm.genmod.families.links.logit()
probit = sm.genmod.families.links.probit()
binomial = sm.families.Binomial


# In[92]:


fit_logit_bis = smf.glm('survived ~ sex + age + pclass + fare', data=t,
                        family=binomial(logit)).fit()


# In[93]:


fit_logit_bis.summary()


# In[94]:


preds = fit_logit_bis.get_prediction(new).summary_frame()


# In[95]:


preds


# In[96]:


preds['age'] = new['age']


# In[98]:


sns.lineplot(data=preds, x='age', y='mean');
plt.fill_between(preds['age'], preds['mean_ci_lower'], preds['mean_ci_upper'], color='blue', alpha=0.1);


# In[ ]:




