# Esli russkie bukvi prevratilitis v krakozyabry, to File - Reopen with
# encoding... - UTF-8 - Set as default - OK

# lab 6

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


x = rnorm(10, mean = 0, sd = 5)
x

x_ts_q = ts(x, start = c(2020, 3), freq = 4)
x_ts_q

x_ts_m = ts(x, start = c(2020, 3), freq = 12)
x_ts_m

d = '2021-01-21'
d
ymd('2021-01-21') + days(7)
ymd('2021-01-21') + months(0:10)

?lubridate

dates = ymd('2021-01-21') + days(c(0, 1, 11:18))
dates

x_irr = xts(x, order.by = dates)
x_irr

# tsibble

x_tsibble = tsibble(growth = x, date = dates)

x_tsibble = tsibble(growth = x, date = dates, index = date)
x_tsibble

x_tsibble2 = mutate(x_tsibble, gr2 = growth ^ 2)
x_tsibble2


mdates = ymd('2020-01-01') + months(0:9)
mdates

x_tsibble_m = tsibble(growth = x, date = mdates)
x_tsibble_m

x_tsibble_m = tsibble(growth = x,
                      date = yearmonth(mdates))
x_tsibble_m


