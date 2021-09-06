library(tidyverse) # манипуляции с данными
library(skimr) # описательные статистики
library(tidymodels) # удобства для оценивания моделей
library(sjPlot) # визуализация коэффициентов
library(car) # проверка сложных гипотез
library(lmtest) # тесты для моделей
library(texreg) # таблички для сравнения моделей

d = swiss
model = lm(data = d,
        Fertility ~ Agriculture + Catholic + Education)
summary(model)

# H0: beta_j = 0 vs Ha: beta_j <> 0
# H0: beta_agric = 0 отвергается

tidy(model)
coeftest(model)

confint(model, level = 0.9)

plot_model(model)

scaler = function(v) {
  res = (v - mean(v, na.rm = TRUE)) / sd(v, na.rm = TRUE)
  return(res)
}

d2 = mutate_all(d, scaler)
glimpse(d)
glimpse(d2)

d3 = mutate_at(d, vars(Agriculture, Education), scaler)
glimpse(d3)

model2 = lm(data = d2,
           Fertility ~ Agriculture + Catholic + Education)
summary(model2)


hyp = 'Agriculture = Catholic'
linearHypothesis(model, hyp)

# H0: beta_agric = beta_cath
# Ha: beta_agric <> beta_cath
# при alpha = 0.01 гипотеза H0 отвергается

hyp2 = c('Agriculture = Catholic', 'Education = 0')
linearHypothesis(model, hyp2)
