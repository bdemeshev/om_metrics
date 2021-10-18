# Esli russkie bukvi prevratilitis v krakozyabry, to File - Reopen with
# encoding... - UTF-8 - Set as default - OK

# lab 08-4

# подключаем пакеты
library(tidyverse) # графики и манипуляции с данными, подключаются пакеты dplyr, ggplot2, etc
library(fpp3) # работа с временными рядами
library(quantmod) # загрузка с finance.yahoo.com
library(sophisthse) # загрузка с sophist.hse.ru


data = sophisthse('POPNUM_Y', output = 'tsibble')
gg_tsdisplay(data, POPNUM_Y)
glimpse(data)

data_train = filter(data, T <= 2016)
data_test = filter(data, T > 2016)

models = model(data_train,
               naive = NAIVE(POPNUM_Y),
               ar1 = ARIMA(POPNUM_Y ~ pdq(1, 0, 0)),
               arima110 = ARIMA(POPNUM_Y ~ pdq(1, 1, 0)),
               auto = ARIMA(POPNUM_Y))

glance(models)

report(models$auto[[1]])

fcst = forecast(models, h = 5)
fcst

accuracy(fcst, data)

autoplot(fcst)
autoplot(fcst, data)

head(fcst)

autoplot(filter(fcst, .model %in% c('naive', 'arima110')),
         filter(data, T > 2000))

