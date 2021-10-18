library(tidyverse) # манипуляции с данными
library(skimr) # описательные статистики
library(tidymodels) # удобства для оценивания моделей
library(sjPlot) # визуализация коэффициентов
library(car) # проверка сложных гипотез
library(lmtest) # тесты для моделей
library(texreg) # таблички для сравнения моделей
library(rio) # import / export всех форматов
library(sjlabelled) # работа с меченными переменными

v28 = import('r28i_os_32.sav')
glimpse(v28)

# рост xm2
# вес xm1
# пол xh5
# год рождения xh6

df_example = tibble(x = rnorm(5),
      w = factor(c('m', 'f', 'f', 'm', 'f')))
glimpse(df_example)

v = select(v28, height = xm2, weight = xm1,
           sex = xh5, birth = xh6)
glimpse(v)

get_label(v$height)
get_label(v$sex)

get_labels(v$sex)
get_values(v$sex)

v2 = mutate(v, sex = as_label(sex))
glimpse(v2)

skim(v2)
get_labels(v$height)
get_values(v$height)

options(scipen = 10)

v3 = mutate_at(v2, vars(height, weight), zap_labels)
skim(v3)


model = lm(data = v3, height ~ sex)
summary(model)

v4 = mutate(v3, sex_b = fct_relevel(sex, 'ЖЕНСКИЙ'))
model_b = lm(data = v4, height ~ sex_b)
summary(model_b)

v5 = mutate(v4,
  sex_c = fct_recode(sex, 'm' = 'МУЖСКОЙ', 'f' = 'ЖЕНСКИЙ'))
glimpse(v5)

v6 = mutate(v5,
  united = fct_collapse(sex, 'happy' = c('МУЖСКОЙ', 'ЖЕНСКИЙ')))
glimpse(v6)
