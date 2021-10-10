# lab 07-4

# подключаем пакеты
library(vcd)  # графики для качественных данных
library(mfx)  # расчет предельных эффектов
library(AUC)  # для ROC кривой
library(skimr) # описательные статистики (вместо psych в видеолекциях)
library(rio) # импорт файлов разных форматов
library(tidyverse) # графики и манипуляции с данными, подключаются пакеты dplyr, ggplot2, etc
library(tidymodels) # работа с моделями
library(huxtable) # таблички для нескольких моделей

# читаем данные по пассажирам Титаника
t = import("titanic3.csv")
# источник и описание:
# http://lib.stat.cmu.edu/S/Harrell/data/descriptions/titanic.html

glimpse(t)

t2 = mutate_at(t, vars(sex, pclass, survived, embarked), factor)
glimpse(t2)

skim(t2)


m_logit = glm(data = t2,
    survived ~ sex + age + pclass + fare,
    family = binomial(link = 'logit'))
m_logit
summary(m_logit)


m_simple = glm(data = t2,
              survived ~ age,
              family = binomial(link = 'logit'))

lrtest(m_simple, m_logit)

t3 = select(t2, sex, age, pclass, fare, survived) %>%
  na.omit()
glimpse(t3)


m_logit = glm(data = t3,
              survived ~ sex + age + pclass + fare,
              family = binomial(link = 'logit'))
m_logit
summary(m_logit)


m_simple = glm(data = t3,
               survived ~ age,
               family = binomial(link = 'logit'))

lrtest(m_simple, m_logit)

# H0: верна простая модель отвергается

# предельные эффекты для среднестатистического пассажира
logitmfx(data = t2,
         survived ~ sex + age + pclass + fare)

# средний предельный эффект по всем пассажирам
logitmfx(data = t2,
         survived ~ sex + age + pclass + fare, atmean = FALSE)
