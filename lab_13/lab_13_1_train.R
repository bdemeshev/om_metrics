library(tidyverse) # манипуляции с данными
library(skimr) # описательные статистики
library(tidymodels) # удобства для оценивания моделей
library(sjPlot) # визуализация коэффициентов
library(car) # проверка сложных гипотез
library(lmtest) # тесты для моделей
library(texreg) # таблички для сравнения моделей
library(rio) # import / export всех форматов
library(sjlabelled) # работа с мечеными переменными
library(boot) # бутстрэп
library(car) # немного бутстрэпа для регрессии

d = cars

get_boot_median = function(vector, indices) {
  resample = vector[indices]
  boot_median = median(resample)
  return(boot_median)
}

set.seed(777)
boot_medians = boot(cars$speed, get_boot_median, R=10000)
boot_medians$t
# bias = difference bootstrap mean vs original
boot.ci(boot_medians)

get_boot_median2 = function(vector, indices) {
  resample = vector[indices]
  boot_median = median(resample)
  boot_mean_var = var(resample) / length(vector)
  return(c(boot_median, boot_mean_var))
}


set.seed(777)
boot_medians = boot(cars$speed, get_boot_median2, R=10000)
boot_medians$t
boot.ci(boot_medians)


get_boot_median3 = function(vector, indices) {
  resample = vector[indices]
  boot_median = median(resample)

  boot_boot = boot(resample, get_boot_median, 100)
  boot_median_var = var(boot_boot$t) / length(vector)

  boot_mean_var = var(resample) / length(vector)
  return(c(boot_median, boot_median_var))
}

set.seed(777)
boot_medians = boot(cars$speed, get_boot_median3, R=1000)
boot_medians$t
boot.ci(boot_medians)

