# lab 07-1

# подключаем пакеты
library(vcd)  # графики для качественных данных
library(skimr) # описательные статистики (вместо psych в видеолекциях)
library(rio) # импорт файлов разных форматов
library(tidyverse) # графики и манипуляции с данными, подключаются пакеты dplyr, ggplot2, etc

# читаем данные по пассажирам Титаника
t = import("titanic3.csv")
# источник и описание:
# http://lib.stat.cmu.edu/S/Harrell/data/descriptions/titanic.html

glimpse(t)

t2 = mutate_at(t, vars(sex, pclass, survived, embarked), factor)
glimpse(t2)

skim(t2)

mosaic(data = t2, ~ sex + pclass + survived, shade = TRUE)

qplot(data = t2, x = survived, y = age, geom = 'violin')

qplot(data = t2, x = survived, y = age, geom = 'boxplot')

ggplot(data = t2,
      aes(x = age, fill = survived,
          y = ..count..)) +
  geom_density(position = 'stack')


ggplot(data = t2,
       aes(x = age, fill = survived,
           y = ..count..)) +
  geom_density(position = 'fill')

