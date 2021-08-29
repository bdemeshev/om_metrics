library(tidyverse) # манипуляции с данными
library(skimr) # описательные статистики

d = cars

qplot(data = d, x = speed, y = dist)  +
  labs(x = 'Скорость (миль в час)',
       y = 'Длина тормозного пути (фт)',
       title = 'Данные по машинам 1920х',
       subtitle = '(встроенный в R набор cars)')


