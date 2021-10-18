# Esli russkie bukvi prevratilitis v krakozyabry, to File - Reopen with
# encoding... - UTF-8 - Set as default - OK

# lab 08-5

# подключаем пакеты
library(tidyverse) # графики и манипуляции с данными, подключаются пакеты dplyr, ggplot2, etc
library(fpp3) # работа с временными рядами
library(quantmod) # загрузка с finance.yahoo.com
library(sophisthse) # загрузка с sophist.hse.ru

data = sophisthse('CPI_M_CHI', output = 'tsibble')
data
tail(data)

gg_tsdisplay(data, CPI_M_CHI)

data00 = filter(data, T >= ymd('2000-01-01'))
gg_tsdisplay(data00, CPI_M_CHI)


data00_train = head(data00, -12)

models = model(data00_train,
               naive = NAIVE(CPI_M_CHI),
               snaive = SNAIVE(CPI_M_CHI),
               ar1 = ARIMA(CPI_M_CHI ~ pdq(1, 0, 0) + PDQ(1, 0, 0)),
               auto = ARIMA(CPI_M_CHI))

glance(models)
report(models$auto[[1]])

fcst = forecast(models, h = 12)
accuracy(fcst, data00)


autoplot(fcst, filter(data00, T > ymd('2015-01-01')))

fcst
