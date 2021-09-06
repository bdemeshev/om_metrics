library(tidyverse) # манипуляции с данными
library(skimr) # описательные статистики
library(tidymodels) # удобства для оценивания моделей
library(sjPlot) # визуализация коэффициентов
library(car) # проверка сложных гипотез
library(lmtest) # тесты для моделей
library(texreg) # таблички для сравнения моделей
library(rio) # import / export всех форматов

n_row = 200
n_col = 51

v = rnorm(n_row * n_col, mean = 0, sd = 1)
v
matr = matrix(v, nrow = n_row)
str(matr)

data = as_tibble(matr)

glimpse(data)

model = lm(data = data, V1 ~ .)
summary(model)
