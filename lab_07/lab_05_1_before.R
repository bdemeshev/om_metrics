# lab 5-1

# подключаем пакеты
library(sandwich) # vcovHC, vcovHAC
library(lmtest) # тесты
library(car) # ещё тесты
library(broom) # манипуляции с моделями
library(rio) # импорт файлов разных форматов
library(estimatr) # модели с робастными стандартными ошибками
library(tidyverse) # графики и манипуляции с данными, подключаются пакеты dplyr, ggplot2, etc
library(tidymodels) # моделирование

sq = function(x) {
  answer = x * x
  return(answer)
}

sq(5)
sq(c(5, 6, NA, Inf))


sq_plus = function(x, power = 2) {
  answer = x ^ power
  return(answer)
}

sq_plus(5)

sq_plus(5, power = 3)

sq_plus(5, 3)
sq_plus(3, 5)

sq_plus(power = 3, 5)


na_percentage = function(data) {
  if (!is.data.frame(data)) {
    stop('Argument of a function should be a data.frame')
  }
  n_na = sum(is.na(data))
  return(n_na / (ncol(data) * nrow(data)))
}

cars
na_percentage(cars)

d = cars
d[5, 1] = NA
d[7, 2] = NA
na_percentage(d)



#' Calculate percentage of NA in a data.frame
#' @param data data frame
#' @return real number, fraction of NA in the data.frame
#' @examples
#' d = cars
#' d[5, 1] = NA
#' d[7, 2] = NA
#' na_percentage(d)
na_percentage = function(data) {
  if (!is.data.frame(data)) {
    stop('Argument of a function should be a data.frame')
  }
  n_na = sum(is.na(data))
  return(n_na / (ncol(data) * nrow(data)))
}

