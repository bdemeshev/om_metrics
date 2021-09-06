library(tidyverse) # манипуляции с данными
library(skimr) # описательные статистики
library(tidymodels) # удобства для оценивания моделей
library(sjPlot) # визуализация коэффициентов
library(car) # проверка сложных гипотез
library(lmtest) # тесты для моделей
library(texreg) # таблички для сравнения моделей
library(rio) # import / export всех форматов

demo = import('~/Documents/coursera_metrics/lab_02/demo.xlsx')
demo

setwd("~/Documents/coursera_metrics/lab_02")
demo = import('demo.xlsx')
demo

flat = import('flats_moscow.txt')
glimpse(flat)

flat = import('flats_moscow.txt', dec = '.', sep = '\t')
glimpse(flat)

model_1 = lm(data = flat, price ~ totsp)
model_2 = lm(data = flat, price ~ livesp + kitsp + brick)
summary(model_1)
summary(model_2)

screenreg(list(model_1, model_2))
texreg(list(model_1, model_2))
htmlreg(list(model_1, model_2))

flat2 = filter(flat, brick == 1)
glimpse(flat2)
glimpse(flat)


export(flat2, file = 'flat2.csv')

model_1

export(model_1, file = 'model_1.Rds')

coeftable_1 = tidy(model_1)
coeftable_1

export(coeftable_1, file = 'model_1.xlsx')
