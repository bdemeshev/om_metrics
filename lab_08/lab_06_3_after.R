# Esli russkie bukvi prevratilitis v krakozyabry, to File - Reopen with
# encoding... - UTF-8 - Set as default - OK

# lab 6-3

# подключаем пакеты
library(sandwich)  # vcovHC, vcovHAC
library(lmtest)  # тесты
library(car)  # ещё тесты
library(xts)  # ещё ряды
library(estimatr) # модели с робастными стандартными ошибками
library(tidyverse) # графики и манипуляции с данными, подключаются пакеты dplyr, ggplot2, etc
library(tidymodels)
library(fpp3)

library(quantmod)  # загрузка с finance.google.com
library(rusquant)  # загрузка с finam.ru
library(sophisthse)  # загрузка с sophist.hse.ru
library(Quandl)  # загрузка с Quandl

data('Investment')
inv = as_tsibble(Investment, pivot_longer = FALSE)


inv

inv2 = mutate(inv, invest_lag = lag(Investment),
              invest_diff = Investment - lag(Investment))
glimpse(inv2)

model = lm(data = inv2, RealInv ~ RealInt + RealGNP)
summary(model)

vcov(model) # оценка ков матрицы в предположении отсутствия корреляции
vcovHAC(model) # оценка ков матрицы устойчивая к автокорреляции

model_hac = lm_robust(data = inv2, se_type = 'HAC',
                      RealInv ~ RealInt + RealGNP)

coeftest(model)
coeftest(model, vcov. = vcovHAC(model))

c_table = coeftest(model, vcov. = vcovHAC(model)) %>% tidy()
c_table

ci = mutate(c_table,
            left_ci = estimate - qnorm(0.975) * std.error,
            right_ci = estimate + qnorm(0.975) * std.error)
ci

bg_res = bgtest(model, order = 2)
bg_res$statistic
bg_res$p.value
# H0: отсутствие корелляции
# Ha: авто-корелляция 2го порядка
# H0 не отвергается

dwt(model)
res_dw = dwt(model)
res_dw$dw
res_dw$p

res_dw$r
