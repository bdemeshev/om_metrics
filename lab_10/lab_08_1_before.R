# Esli russkie bukvi prevratilitis v krakozyabry, to File - Reopen with
# encoding... - UTF-8 - Set as default - OK

# lab 08-1

# подключаем пакеты
library(tidyverse) # графики и манипуляции с данными, подключаются пакеты dplyr, ggplot2, etc
library(fpp3) # работа с временными рядами
library(quantmod) # загрузка с finance.yahoo.com
library(sophisthse) # загрузка с sophist.hse.ru


# AR(1) y_t = 0.7 y_{t-1} + u_t
short_ts = tsibble(
  date = yearmonth(ymd('2010-01-01') + months(0:99)),
  ar1 = arima.sim(n = 100, list(ar = 0.7)),
  index = date
)
short_ts
gg_tsdisplay(short_ts, ar1)
ACF(short_ts, ar1)
PACF(short_ts, ar1) %>% autoplot()

set.seed(777)
# MA(1) y_t = u_t - 0.8 u_{t-1}
short_ts = mutate(short_ts,
      ma1 = arima.sim(n = 100, list(ma = -0.8))
)

gg_tsdisplay(short_ts, ma1)
PACF(short_ts, ma1) %>% autoplot()

# ARMA(1) y_t = 0.5 y_{t-1} + u_t - 0.8 u_{t-1}
short_ts = mutate(short_ts,
    arma1 = arima.sim(n = 100,
                      list(ma = -0.8, ar = 0.5))
)

gg_tsdisplay(short_ts, arma1)
PACF(short_ts, arma1) %>% autoplot()
