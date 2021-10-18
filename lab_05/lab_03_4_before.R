# lab 3-3

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

f = mutate_at(f, vars(walk, brick, floor, code), factor)

qplot(data = f, x = log(totsp),
      y = log(price)) +
  labs(x = 'Логарифм общей площади квартиры (м2)',
       y = 'Логарифм цены квартиры (тыс. долл.)',
       title = 'Соотношение цены и площади квартиры в Москве')

m1 = lm(data = f, log(price) ~ log(totsp))
m2 = lm(data = f, log(price) ~ log(totsp) + brick)
m3 = lm(data = f,
        log(price) ~ log(totsp) + brick +
                        brick:log(totsp))

huxreg(m1, m2, m3)

# m1 vs m2, F-test
waldtest(m1, m2)
# p-value < alpha = 0.01
# H0 is rejected
# H0: R-model is TRUE
# Ha: UR-model is TRUE

# m1 vs m3, F-test
waldtest(m1, m3)

# m2 vs m3, F-test
waldtest(m2, m3)
# alpha = 0.01
# H0: model 2 is TRUE is not rejected

base_plot = qplot(data = f, x = log(totsp),
                  y = log(price))
base_plot
base_plot + stat_smooth(method = 'lm')
base_plot + stat_smooth(method = 'lm') +
  facet_grid(~ walk)

base_plot + aes(col = brick) +
  stat_smooth(method = 'lm') +
  facet_grid(~ walk)

# RESET Ramsey test
resettest(m3)
# alpha = 0.01

