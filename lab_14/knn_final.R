library(tidyverse)
library(caret)
library(rio)
library(skimr)
library(expm)

flats = import('flats_moscow.txt')
glimpse(flats)
flats_ = select(flats, -n, -code)

set.seed(777)
train_row = createDataPartition(y = flats_$price,
                                p = 0.8,
                                list = FALSE)
train_row
flats_train = flats_[train_row, ]
flats_test = flats_[-train_row, ]

train_params = trainControl(method = 'repeatedcv',
            number = 10, repeats = 3)

set.seed(777)
knn_fit = train(data = flats_train, method = 'knn',
                price ~ .,
                preProcess = c('center', 'scale'),
                tuneLength = 10)
knn_fit


set.seed(777)
ols_fit = train(data = flats_train, method = 'lm',
                price ~ .,
                preProcess = c('center', 'scale'))
ols_fit

