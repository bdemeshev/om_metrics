# Esli russkie bukvi prevratilitis v krakozyabry, to File - Reopen with
# encoding... - UTF-8 - Set as default - OK

# lab 10-1

# подключаем пакеты
library(reshape2)  # перевод таблиц: широкая-длинная
library(MCMCpack)  # байесовский подход к популярным моделям
library(quantreg)  # квантильная регрессия
library(ranger)  # быстрый случайный лес (замена для randomForest)
library(rattle)  # визуализация деревьев
library(caret)  # стандартный подход к регрессионным и классификационным задачам
library(rpart)  # классификационные и регрессионные деревья
library(rio) # импорт файлов разных форматов
library(tidyverse) # графики и манипуляции с данными, подключаются пакеты dplyr, ggplot2, etc

f = import('flats_moscow.txt')
glimpse(f)

qplot(data = f, x = totsp, y = price)
model_q = rq(data = f,
             price ~ totsp,
             tau = c(0.1, 0.5, 0.9))
summary(model_q)

base = qplot(data = f, x = totsp, y = price) +
  labs(x = 'Площадь квартиры (м2)',
       y = 'Цена квартиры (тыс. уе.)',
       title = 'Исторические данные по стоимости кварир в Москве')
base
base_q = base + stat_smooth(method = 'rq',
      method.args = list(tau = 0.1),
      se = FALSE) +
  stat_smooth(method = 'rq',
                method.args = list(tau = 0.9),
                se = FALSE)
base_q
base_q + aes(colour = factor(brick))
