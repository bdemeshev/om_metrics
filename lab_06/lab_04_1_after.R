# lab 4-1

# подключаем пакеты
library(HSAUR)  # из этого пакета возьмем набор данных по семиборью
library(skimr) # описательные статистики (вместо psych в видеолекциях)
library(lmtest)  # тесты для линейных моделей
library(glmnet)  # LASSO + ridge
library(car)  # vif
library(factoextra) # симпатичные графики для метода главных компонент
library(tidyverse) # графики и манипуляции с данными, подключаются пакеты dplyr, ggplot2, etc
library(tidymodels) # плюшки для моделей
library(corrplot) # картинки для корреляционной матрицы

h = cars

qplot(data = h, x = speed, y = dist)

h2 = mutate(h, speed2 = speed ^2, speed3 = speed ^ 3)

model_0 = lm(data = h2, dist ~ speed)
model_1 = lm(data = h2, dist ~ speed + speed2 + speed3)
summary(model_0)
summary(model_1)


vif(model_1)

corr_mat = cor(h2)
corr_mat

corrplot.mixed(corr_mat, order = 'hclust')

confint(model_1)
coeftest(model_1)


new = tibble(speed = 10, speed2 = 100, speed3 = 1000)
predict(model_1, newdata = new,
        interval = 'prediction')

predict(model_0, newdata = new,
        interval = 'prediction')

