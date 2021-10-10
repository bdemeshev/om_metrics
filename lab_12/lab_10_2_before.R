# Esli russkie bukvi prevratilitis v krakozyabry, to File - Reopen with
# encoding... - UTF-8 - Set as default - OK

# lab 10-2

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

f2 = mutate(f, log_price = log(price), log_totsp = log(totsp),
            remsp = totsp - kitsp - livesp,
            log_kitsp = log(kitsp),
            log_remsp = log(remsp),
            log_livesp = log(livesp)
)

set.seed(777) # на удачи!
train = createDataPartition(y = f2$log_price, p = 0.8, list = FALSE)
train

f_train = f2[train, ]
f_test = f2[-train, ]

model_ols = lm(data = f_train, log_price ~ log_livesp + log_kitsp + log_remsp)
model_rf = ranger(data = f_train,
        log_price ~ log_livesp + log_kitsp + log_remsp)

yhat_ols = predict(model_ols, newdata = f_test)
?predict.ranger
yhat_rf = predict(model_rf, data = f_test)$predictions

RMSE(yhat_ols, f_test$log_price)
RMSE(yhat_rf, f_test$log_price)



caret_ols = train(data = f_train, method = 'lm',
                  log_price ~ log_livesp + log_kitsp + log_remsp)
caret_rf = train(data = f_train, method = 'ranger',
                  log_price ~ log_livesp + log_kitsp + log_remsp)

caret_ols
caret_rf

yhat_ols_caret = predict(caret_ols, newdata = f_test)
yhat_rf_caret = predict(caret_rf, newdata = f_test)

RMSE(yhat_ols_caret, f_test$log_price)
RMSE(yhat_rf_caret, f_test$log_price)

