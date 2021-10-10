# Esli russkie bukvi prevratilitis v krakozyabry, to File - Reopen with
# encoding... - UTF-8 - Set as default - OK

# lab 09-2

# подключаем пакеты
library(caret) # стандартизованный подход к регрессионным и классификационным моделям
library(AER) # инструментальные переменные
library(sandwich) # робастные стандартные ошибки
library(ivpack) # дополнительные плющки для инструментальных переменных
# library(memisc) # табличка mtable
library(rio) # импорт файлов разных форматов
library(tidyverse) # графики и манипуляции с данными, подключаются пакеты dplyr, ggplot2, etc
library(huxtable) # сравнение нескольких табличек
library(estimatr) # robust se

# оценивание заданной формы модели с эндогенностью
data('CigarettesSW', package = 'AER')
h = CigarettesSW
glimpse(h)
help('CigarettesSW')

qplot(data = h, x = price, y = packs)
h95 = filter(h, year == '1995')

h2 = mutate(h95,
            rprice = price / cpi,
            rincome = income / (cpi * population),
            tdiff = (taxs - tax) / cpi)
qplot(data = h2, x = price, y = packs)
qplot(data = h2, x = rprice, y = packs)

# МНК
model_0 = lm(data = h2, log(packs) ~ log(rprice))
summary(model_0)


# 2МНК руками:
stage_1 = lm(data = h2, log(rprice) ~ tdiff)
stage_1
h3 = mutate(h2, log_price_hat = fitted(stage_1))
stage_2 = lm(data = h3, log(packs) ~ log_price_hat)

stage_2
summary(stage_2) # se лгут!

model_iv = ivreg(data = h2,
      log(packs) ~ log(rprice) | tdiff)
summary(model_iv)

model_iv_hc = iv_robust(data = h2,
                 log(packs) ~ log(rprice) | tdiff)
summary(model_iv_hc)


huxreg(model_0, model_iv, model_iv_hc)


model_iv_hc2 = iv_robust(data = h2,
      log(packs) ~ log(rprice) + log(rincome)
      | tdiff + log(rincome))
summary(model_iv_hc2)

