# Esli russkie bukvi prevratilitis v krakozyabry, to File - Reopen with
# encoding... - UTF-8 - Set as default - OK

# lab 08-3

# подключаем пакеты
library(tidyverse) # графики и манипуляции с данными, подключаются пакеты dplyr, ggplot2, etc
library(fpp3) # работа с временными рядами
library(quantmod) # загрузка с finance.yahoo.com
library(sophisthse) # загрузка с sophist.hse.ru

LakeHuron

lake = as_tsibble(LakeHuron)
lake

gg_tsdisplay(lake, value)
PACF(lake, value) %>% autoplot()

lake_train = head(lake, -10)
lake_test = tail(lake, 10)
lake_test

models = model(lake_train,
    naive = NAIVE(value),
    ar1 = ARIMA(value ~ pdq(1, 0, 0)),
    ar2 = ARIMA(value ~ pdq(2, 0, 0)),
    arma11 = ARIMA(value ~ pdq(1, 0, 1)),
    arima_auto = ARIMA(value))


models
report(models$ar1[[1]])
# y_t = 97 + 0.83 y_{t-1} + u_t
report(models$arima_auto[[1]])

glance(models)

fcst = forecast(models, h = 10)
fcst

accuracy(fcst, lake)

autoplot(fcst)

autoplot(fcst, lake)


lake
autoplot(filter(fcst, .model %in% c('ar1', 'naive')),
         filter(lake, index >= 1925))
