# lab 5-2

# подключаем пакеты
library(sandwich) # vcovHC, vcovHAC
library(lmtest) # тесты
library(car) # ещё тесты
library(broom) # манипуляции с моделями
library(rio) # импорт файлов разных форматов
library(estimatr) # модели с робастными стандартными ошибками
library(tidyverse) # графики и манипуляции с данными, подключаются пакеты dplyr, ggplot2, etc
library(tidymodels) # моделирование

d = cars
glimpse(d)
head(d)

d2 = mutate(d, dist2 = dist ^ 2)
head(d2)

for (i in 7:21) {
  i_sq = i ^ 2
  cat('Квадрат ', i, ' равен ', i_sq, '\n')
}

for (i in 11:20) {
  d = head(cars, i)
  file_name = paste0('part_of_cars_', i, '.csv')
  export(d, file_name)
}
getwd()
setwd("~/Documents/coursera_metrics/lab_05")

all_files = list.files(pattern = 'part_of_cars*')
all_files

all_data = NULL
for (file_name in all_files) {
  d = import(file_name)
  d2 = mutate(d, origin = file_name)
  all_data = bind_rows(all_data, d2)
}

