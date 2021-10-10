# lab 4-3

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

h = heptathlon
glimpse(h)

h_nos = select(h, -score)
skim(h_nos)

corr_mat = cor(h_nos)
corrplot.mixed(corr_mat, order = 'hclust')

h_pca = prcomp(h_nos, scale = TRUE)
pca1 = h_pca$x[, 1]
head(pca1)

v1 = h_pca$rotation[, 1]
v1

summary(h_pca)

cor(h$score, pca1)

fviz_eig(h_pca)

fviz_pca_biplot(h_pca, repel = TRUE)
