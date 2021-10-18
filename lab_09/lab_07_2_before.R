# lab 07-2

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

m_probit = glm(data = t2,
      survived ~ sex + age + pclass + fare,
      family = binomial(link = 'probit'))
summary(m_probit)

huxreg(m_logit, m_probit)

vcov(m_logit)

new = tibble(age = seq(from = 5, to = 100, length = 100),
             sex = 'male', pclass = '2nd', fare = 100)
glimpse(new)

new2 = augment(m_logit, newdata = new, se = TRUE)
glimpse(new2)

z_crit = 1.96
new3 = mutate(new2,
        prob = plogis(.fitted),
        left_ci = plogis(.fitted - z_crit * .se.fit),
        right_ci = plogis(.fitted + z_crit * .se.fit))

glimpse(new3)


qplot(data = new3, x = age, y = prob, geom = 'line')

qplot(data = new3, x = age, y = prob, geom = 'line') +
  geom_ribbon(aes(ymin = left_ci,
                  ymax = right_ci), alpha = 0.2)
