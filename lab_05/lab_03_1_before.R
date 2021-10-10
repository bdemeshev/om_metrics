# lab 3-1

# подключаем пакеты
library(skimr) # описательные статистики (вместо psych в видеолекциях)
library(lmtest) # тестирование гипотез в линейных моделях
library(rio) # загрузка данных в разных форматах (вместо foreign в видеолекциях)
library(vcd) # мозаичные графики
library(hexbin) # двумерный график с шестиугольниками
library(sjPlot) # визуализация результатов регрессии
library(tidyverse) # графики и манипуляции с данными, подключаются пакеты dplyr, ggplot2, etc
library(tidymodels) # удобства для манипуляций с моделями
library(huxtable) # несколько таблиц вместе

d = diamonds
glimpse(d)

qplot(data = d, x = carat, y = price) +
  labs(x = 'Масса (карат)',
       y = 'Цена (долл)',
       title = 'Соотношение массы и цены бриллианта',
       subtitle = '(данные из набора diamonds в R)')

qplot(data = d, x = carat, y = price) +
  labs(x = 'Масса (карат)',
       y = 'Цена (долл)',
       title = 'Соотношение массы и цены бриллианта',
       subtitle = '(данные из набора diamonds в R)') +
  geom_hex()


f = import('flats_moscow.txt')
glimpse(f)

qplot(data = f, x = totsp, y = price)

qplot(data = f, x = log(totsp),
      y = log(price))

glimpse(f)

f = mutate_at(f, vars(walk, brick, floor, code), factor)
glimpse(f)

cos(f$code)

mosaic(data = f, ~ walk + brick + floor, shade = TRUE)
