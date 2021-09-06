library(tidyverse) # манипуляции с данными
library(skimr) # описательные статистики
library(tidymodels) # удобства для оценивания моделей
library(sjPlot) # визуализация коэффициентов
library(car) # проверка сложных гипотез
library(lmtest) # тесты для моделей
library(texreg) # таблички для сравнения моделей
library(rio) # import / export всех форматов
library(sjlabelled) # работа с мечеными переменными

v28 = import('r28i_os_32.sav')
glimpse(v28)

# рост xm2
# вес xm1
# пол xh5
# год рождения xh6

v = select(v28, sex = xh5, weight = xm1,
           height = xm2, birth = xh6)
glimpse(v)

str(v)
attr(v$sex, 'label')
attr(v$sex, 'labels')

get_label(v$sex)
get_labels(v$sex)
get_values(v$sex)

v2 = mutate(v, sex = as_label(sex))
glimpse(v2)
skim(v2)

v3 = mutate_at(v2, vars(weight, height), zap_labels)
glimpse(v3)

lm(data=v3, height ~ sex)

v4 = mutate(v3, sex_b = fct_relevel(sex, 'ЖЕНСКИЙ'))

lm(data=v4, height ~ sex_b)

v5 = mutate(v4,
      sex_c = fct_recode(sex, 'm'='МУЖСКОЙ', 'f'='ЖЕНСКИЙ'))
glimpse(v5)

str(v5$sex)
str(v5$sex_b)
str(v5$sex_c)


v6 = mutate(v5,
    sex_d = fct_collapse(sex, 'happy'=c('МУЖСКОЙ', 'ЖЕНСКИЙ')))
head(v6, 10)

