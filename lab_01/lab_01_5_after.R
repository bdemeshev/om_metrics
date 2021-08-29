library(tidyverse) # манипуляции с данными
library(skimr) # описательные статистики
library(tidymodels) # удобства для оценивания моделей

help(swiss)
glimpse(swiss)
skim(swiss)

qplot(data = swiss, Catholic)

d = swiss

model = lm(data = d,
    Fertility ~ Agriculture + Catholic + Education)
summary(model)

RSS = deviance(model)
RSS

hat_u = resid(model)
hat_u

hat_y = fitted(model)
hat_y

new = tibble(Agriculture = 50, Catholic = 50,
             Education = 20)
new

predict(model, newdata = new)

new2 = augment(model, newdata = new)
new3 = rename(new2, forecast = .fitted)
new3

cor(hat_y, d$Fertility)
cor(hat_y, d$Fertility) ^ 2
summary(model)

tidy(model)
report = glance(model)

