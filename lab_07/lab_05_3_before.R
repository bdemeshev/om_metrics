# lab 5-3

# подключаем пакеты
library(sandwich) # vcovHC, vcovHAC
library(lmtest) # тесты
library(car) # ещё тесты
library(broom) # манипуляции с моделями
library(rio) # импорт файлов разных форматов
library(estimatr) # модели с робастными стандартными ошибками
library(tidyverse) # графики и манипуляции с данными, подключаются пакеты dplyr, ggplot2, etc
library(tidymodels) # моделирование
library(huxtable) # сравнение табличек

d = import('flats_moscow.txt')
head(d)
glimpse(d)

qplot(data = d, x = totsp, y = price)

qplot(data = d, x = log(totsp), y = log(price))

model = lm(price ~ totsp, data = d)
summary(model)

coeftest(model)
confint(model)

# оценка ковар матрицы в предположении гомоскедастичности
vcov(model)

model_hc0 = lm_robust(price ~ totsp, data = d,
                      se_type = 'HC0')
summary(model_hc0)

huxreg(model, model_hc0)

confint(model_hc0)


model_hc3 = lm_robust(price ~ totsp, data = d,
                      se_type = 'HC3')

model_st = lm_robust(price ~ totsp, data = d,
                      se_type = 'HC1')

huxreg(model_hc0, model_st, model_hc3)


bptest(model)
# H0: квадраты остатков не предсказываются регрессорами
# H0 отвергается
bptest(model, data = d,
       varformula = ~ kitsp + I(kitsp ^ 2))


gqtest(model, order.by = ~ totsp, data = d,
       fraction = 0.2)
# H0: дисперсии в двух кусочках набора данных одинаковые
# H0 отвергается

