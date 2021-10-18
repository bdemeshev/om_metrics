# Esli russkie bukvi prevratilitis v krakozyabry, to File - Reopen with
# encoding... - UTF-8 - Set as default - OK

# lab 6-2

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
Investment
?Investment

start(Investment)
end(Investment)
frequency(Investment)

window(Investment, start = 1970, end = 1980)

inv = as_tsibble(Investment)
inv


inv = as_tsibble(Investment, pivot_longer = FALSE)
inv

filter(inv, index >= 1970, index <= 1980)

Sys.setlocale('LC_TIME', 'C')
getSymbols(Symbols = 'AAPL', from = '2020-01-01',
           to = '2021-01-01', src = 'yahoo')
head(AAPL)
tail(AAPL)

plot(AAPL)
autoplot(AAPL[, 1:4])
autoplot(AAPL[, 1:4], facets = NULL)
chartSeries(AAPL)

getSymbols(Symbols = 'GAZP', from = '2020-01-01',
           to = '2021-01-01', src = 'Finam')
chartSeries(GAZP)


popul = sophisthse('POPNUM_Y', output = 'tsibble')
popul


