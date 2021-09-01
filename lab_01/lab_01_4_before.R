# Заготовка скрипта 1-4

# If you can't see cyrillic letters then:
# 1. Go to File - Reopen with encoding -
# 2. Select UTF-8
# 3. Enjoy!

library(tidyverse) # манипуляции с данными
library(skimr) # описательные статистики

d = cars

qplot(data = d, x = speed, y = dist)  +
  labs(x = 'Скорость (миль в час)',
       y = 'Длина тормозного пути (фт)',
       title = 'Данные по машинам 1920х',
       subtitle = '(встроенный в R набор cars)')


