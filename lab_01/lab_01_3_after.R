library(tidyverse) # манипуляции с данными
library(skimr) # описательные статистики

cars
d = cars

glimpse(d)
?cars

ncol(d)
nrow(d)
colnames(d)
str(d)
head(d)
head(d, 3)
tail(d, 7)

mean(d$dist)
mean(d$speed)

skim(d)

qplot(data = d, dist)

qplot(data = d, dist) +
  labs(x = 'Длина тормозного пути (фт)',
       y = 'Количество машин',
       title = 'Данные по машинам 1920х',
       subtitle = '(встроенный в R набор cars)')

qplot(data = d, x = speed, y = dist)  +
  labs(x = 'Скорость (миль в час)',
       y = 'Длина тормозного пути (фт)',
       title = 'Данные по машинам 1920х',
       subtitle = '(встроенный в R набор cars)')


