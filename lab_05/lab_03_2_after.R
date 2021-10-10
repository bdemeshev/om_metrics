# lab 3-2

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


f = import('flats_moscow.txt')
glimpse(f)

qplot(data = f, x = log(totsp),
      y = log(price)) +
  labs(x = 'Логарифм общей площади квартиры (м2)',
       y = 'Логарифм цены квартиры (тыс. долл.)',
       title = 'Соотношение цены и площади квартиры в Москве')

f = mutate_at(f, vars(walk, brick, floor, code), factor)

qplot(data = f, x = log(price), fill = brick)

ggplot(data = f, aes(x = log(price), fill = brick)) +
  geom_histogram(position = 'dodge')

qplot(data = f, x = log(price),
      fill = brick, geom = 'density')

plot_a = qplot(data = f, x = log(price),
      fill = brick, geom = 'density', alpha = 0.3)
plot_a

plot_a + facet_grid(walk ~ floor)

plot_a + facet_grid(~ walk)

