library(tidyverse) # манипуляции с данными
library(skimr) # описательные статистики
library(tidymodels) # удобства для оценивания моделей
library(sjPlot) # визуализация коэффициентов
library(car) # проверка сложных гипотез
library(lmtest) # тесты для моделей
library(texreg) # таблички для сравнения моделей
library(rio) # import / export всех форматов
library(labelled)
library(sjlabelled)

v28 = import('r28i_os_32.sav')
glimpse(v28)
var_label(v28)
var_labels(v28$xm1)
val_labels(v28)
d = generate_dictionary(v28)


attr(v28$x_age, 'labels')

v25bis = set_value_labels(v28, x_age = attr(v28$x_age, 'labels'))
v25bis = set_value_labels(v28, xm1 = attr(v28$xm1, 'labels'))

val_labels(v25bis$x_age)

v25bis$x_age
glimpse(v25bis)

mean(v25bis$xm1)
mean(v28$xm1)

?val_labels_to_na()


v25bb = mutate(v25bis, xm1 = val_labels_to_na(xm1))




mean(v25bb$xm1)
v25bb$xm1

?set_value_labels
a = val_labels_to_na(v28$x_age)

hist(v28$xh6)

max(v28$xh6)
a = v28$xh6

v28sel = select(v28, xh6, xh5, xm1)
skim(v28sel)

a = v28sel$xm1
max(a)
hist(a)
b = val_labels_to_na(v28sel$xm1)
max(b)

source_data_sj <- sjlabelled::read_spss('r28i_os_32.sav')

dictionnary2 = labelled::look_for(v28)


# рост xm2
# вес xm1
# пол xh5
# год рождения xh6

h2 = select(v28, height = xm2, weight = xm1,
            sex = xh5, b_year = xh6)
glimpse(h2)

h3 = mutate(h2, age = 2019 - b_year)
glimpse(h3)

h4 = mutate(h3, sex2 =
              case_when(sex == 1 ~ 'male',
                        sex == 2 ~ 'female'))
glimpse(h4)

skim(h4)

h5 = mutate(h4, height =
              case_when(height > 300 ~ NA_real_,
                        TRUE ~ height))
glimpse(h5)
skim(h5)

h6 = mutate(h5, weight =
              case_when(weight > 1000 ~ NA_real_,
                        TRUE ~ weight))
skim(h6)
