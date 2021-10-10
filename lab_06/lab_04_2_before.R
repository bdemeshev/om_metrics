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

h2 = mutate(h, speed2 = speed^2, speed3 = speed^3)

y = h$dist
X0 = model.matrix(data = h2, dist ~ 0 + speed + speed2 + speed3)

y
X0

lambda = seq(from = 50, to = 0.01, length = 30)
lambda

m_lasso = glmnet(X0, y, alpha = 1, lambda = lambda)
m_lasso

m_ols = lm(data = h2, dist ~ speed + speed2 + speed3)
summary(m_ols)


plot(m_lasso, xvar = 'lambda', label = TRUE)

plot(m_lasso, xvar = 'dev', label = TRUE)

plot(m_lasso, xvar = 'norm', label = TRUE)

coef(m_lasso, s = c(1.73, 10.35), exact = TRUE, x = X0, y = y)


m_ridge = glmnet(X0, y, alpha = 0, lambda = lambda)
m_ridge

coef(m_ridge, s = c(1.73, 10.35), exact = TRUE, x = X0, y = y)


plot(m_ridge, xvar = 'lambda', label = TRUE)

plot(m_ridge, xvar = 'dev', label = TRUE)

plot(m_ridge, xvar = 'norm', label = TRUE)


cv_lambda = cv.glmnet(X0, y, alpha = 1)
plot(cv_lambda)

cv_lambda$lambda.min
cv_lambda$lambda.1se

coef(cv_lambda, s = 'lambda.1se')
