# Esli russkie bukvi prevratilitis v krakozyabry, to File - Reopen with
# encoding... - UTF-8 - Set as default - OK

# lab 09-1

# подключаем пакеты
library(caret) # стандартизованный подход к регрессионным и классификационным моделям
library(AER) # инструментальные переменные
library(sandwich) # робастные стандартные ошибки
library(ivpack) # дополнительные плющки для инструментальных переменных
library(memisc) # табличка mtable
library(rio) # импорт файлов разных форматов
library(tidyverse) # графики и манипуляции с данными, подключаются пакеты dplyr, ggplot2, etc


######################### задача прогнозирования
f = import('flats_moscow.txt')
glimpse(f)

f2 = mutate(f, log_price = log(price), log_totsp = log(totsp),
            remsp = totsp - kitsp - livesp,
            log_kitsp = log(kitsp),
            log_remsp = log(remsp),
            log_livesp = log(livesp)
            )

set.seed(777) # на удачу :)

train = createDataPartition(y = f2$log_price, p = 0.8, list = FALSE)
train

f2_train = f2[train, ]
f2_test = f2[-train, ]
nrow(f2_train)
nrow(f2_test)


mod_1 = lm(data = f2_train, log_price ~ log_kitsp + log_remsp + log_livesp)
mod_2 = lm(data = f2_train, log_price ~ log_totsp)

pred_1 = predict(mod_1, newdata = f2_test)
pred_2 = predict(mod_2, newdata = f2_test)

RMSE(pred_1, f2_test$log_price)
RMSE(pred_2, f2_test$log_price)

# альтернативный вариант
caret_mod_1 = train(data = f2_train,
                    log_price ~ log_kitsp + log_remsp + log_livesp,
                    method = 'lm')
caret_mod_1

caret_mod_2 = train(data = f2_train,
                    log_price ~ log_totsp,
                    method = 'lm')
caret_mod_2

caret_pred_1 = predict(caret_mod_1, newdata = f2_test)
caret_pred_2 = predict(caret_mod_2, newdata = f2_test)


RMSE(caret_pred_1, f2_test$log_price)
RMSE(caret_pred_2, f2_test$log_price)

