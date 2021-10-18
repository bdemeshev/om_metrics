# Esli russkie bukvi prevratilitis v krakozyabry, to File - Reopen with
# encoding... - UTF-8 - Set as default - OK

# lab 08-6

# подключаем пакеты
library(tidyverse) # графики и манипуляции с данными, подключаются пакеты dplyr, ggplot2, etc
library(fpp3) # работа с временными рядами
library(quantmod) # загрузка с finance.yahoo.com
library(sophisthse) # загрузка с sophist.hse.ru
library(skimr) # описательные статистики
library(rio) # загрузка данных

# Источник данных:
# https://fedstat.ru/indicator/33553

d = import('original_marriage_data.xls')


d = import('original_marriage_data.xls', skip = 2)
colnames(d)[1:3] = c('region', 'unit', 'period')
glimpse(d)

d2 = select(d, -unit)
d3 = filter(d2, nchar(period) < 13)

d3bis = mutate(d3, months = rep(1:12, nrow(d3) / 12))

d4 = pivot_longer(d3bis, cols = `2006`:`2020`,
                  names_to = 'year',
                  values_to = 'marriages')

nrow(d3) / 12
months = rep(1:12, nrow(d3) / 12)
months

d5 = select(d4, -period)
glimpse(d5)

d6 = mutate(d5, date = ymd(paste0(year, '-', months, '-01')))
glimpse(d6)

d7 = select(d6, -months, -year)

export(d7, 'marriages.csv')
d8 = mutate(d7, date = yearmonth(date))
marr = tsibble(d8, index = date, key = region)

marr

marr2 = separate(marr,
                 region,
                 into = c('code', 'name'),
                 sep = ' ',
                 extra = 'merge'
                 )
marr2

marr2 = as_tsibble(marr2, key = c('code', 'name'), index = date)
marr2


autoplot(filter(marr2, code == '01000000000'), marriages)
