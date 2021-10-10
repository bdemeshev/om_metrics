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
summary(m1)
summary(m2)
summary(m3)

huxreg(m1, m2, m3)


new = tibble(totsp = c(60, 70),
             brick = factor(c(1, 0)))
new

# точечный прогноз
fcst = predict(m2, newdata = new)
fcst
exp(fcst)

# доверительный интервал для ожидаемой стоимости
fcst_ci = predict(m2, newdata = new,
                  interval = 'confidence')
fcst_ci
exp(fcst_ci)

# предиктивный интервал для стоимости конкретной квартиры
fcst_pi = predict(m2, newdata = new,
                  interval = 'prediction')
fcst_pi
exp(fcst_pi)
