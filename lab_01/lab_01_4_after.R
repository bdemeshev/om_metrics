library(tidyverse) # манипуляции с данными
library(skimr) # описательные статистики
library(tidymodels) # удобства для оценивания моделей

d = cars

qplot(data = d, x = speed, y = dist)  +
  labs(x = 'Скорость (миль в час)',
       y = 'Длина тормозного пути (фт)',
       title = 'Данные по машинам 1920х',
       subtitle = '(встроенный в R набор cars)')

model_a = lm(data = d, dist ~ speed)
summary(model_a)

coef(model_a)

beta_hat = coef(model_a)
beta_hat['speed']
beta_hat[2]

hat_u = resid(model_a)
hat_u

y = d$dist
TSS = sum((y - mean(y))^2)
TSS

RSS = deviance(model_a)
RSS

ESS = TSS - RSS
ESS

R2 = ESS / TSS
R2

tidy(model_a)
glance(model_a)

model_b = lm(data = d, dist ~ 0 + speed)
summary(model_b)

d2 = mutate(d, speed_sq = speed ^ 2)
glimpse(d)

glimpse(d2)


model_c = lm(data = d2, dist ~ speed + speed_sq)
summary(model_c)

new = tibble(speed = c(10, 20))
new

predict(model_a, newdata = new)
augment(model_a, newdata = new)

new = mutate(new, speed_sq = speed ^ 2)
augment(model_c, newdata = new)

