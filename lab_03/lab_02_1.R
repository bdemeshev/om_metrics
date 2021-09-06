library(tidyverse) # манипуляции с данными
library(skimr) # описательные статистики
library(tidymodels) # удобства для оценивания моделей

# сгенерируем вектор из 100 нормальных N(5, 9)
# в книгах: 9 — дисперсия
z = rnorm(100, mean = 5, sd = sqrt(9))
z
z[23]
z[20:25]

set.seed(777)
z = rnorm(100, mean = 5, sd = sqrt(9))
z

qplot(x = z)

# нарисуем функцию плотности
xy_table = tibble(x = seq(from = -5, to = 15, by = 0.1),
                  y = dnorm(x, mean = 5, sd = 3))
xy_table

qplot(data = xy_table, x = x, y = y, geom = 'line')

# Z ~ N(0, 1)
# P(Z < 0.42), P(Z > 0.42), P(|Z| > 0.42)

pnorm(0.42, mean = 0, sd = 1)
pnorm(0.42)

1 - pnorm(0.42, mean = 0, sd = 1)

2 * (1 - pnorm(0.42, mean = 0, sd = 1))

# a? при котором P(Z < a) = 0.15
qnorm(0.15)

# другие распределения
# d|r|p|q + norm|t|f|chisq|...

# R ~ t_7
# P(R < 1.5), P(R > 1.5), P(|R| > 1.5)

pt(1.5, df = 7)

1 - pt(1.5, df = 7)

2 * (1 - pt(1.5, df = 7))

# a? P(R < a) = 0.15
qt(0.15, df = 7)
