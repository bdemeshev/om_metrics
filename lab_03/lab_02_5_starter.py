#!/usr/bin/env python
# coding: utf-8

import numpy as np # математические операции
import pandas as pd # операции с табличками
import statsmodels.formula.api as smf # модели 
from sklearn.linear_model import LinearRegression # линейная регрессия без статистики
import seaborn as sns # графики
import matplotlib.pyplot as plt # графики


# pip install rdatasets # наборы данных
# pip install pyreadstat # чтение spss/stata данных
from rdatasets import data 
from pyreadstat import read_sav, set_value_labels

# рост xm2
# вес xm1
# пол xh5
# год рождения xh6
# возраст x_age
