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
library(sandwich) # HC оценки дисперсии оценок коэффициентов
library(lmboot) # бутстрэп коэффициентов
library(car) # ещё немного бутстрэпа для регрессии

d = cars
glimpse(d)

mod_zero = lm(data = d, dist ~ speed)
summary(mod_zero)
confint(mod_zero)

set.seed(777)
wild_boot = wild.boot(data=d, dist ~ speed, B = 10000)
wild_boot$bootEstParam
beta_speed = wild_boot$bootEstParam[, 2]
beta_speed

quantile(beta_speed, probs = c(0.025, 0.975))



set.seed(777)
paired_boot = paired.boot(data=d, dist ~ speed, B = 10000)
paired_boot$bootEstParam
beta_speed = paired_boot$bootEstParam[, 2]
beta_speed

quantile(beta_speed, probs = c(0.025, 0.975))

get_ratio = function(model) {
  result = coef(model)[2] / coef(model)[1]
  return(result)
}
get_ratio(mod_zero)

paired_boot = Boot(mod_zero, f = get_ratio, R = 10000)
summary(paired_boot)
confint(paired_boot, type = 'basic')
