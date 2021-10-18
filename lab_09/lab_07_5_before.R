# lab 07-5

# подключаем пакеты
library(vcd)  # графики для качественных данных
library(mfx)  # расчет предельных эффектов
library(AUC)  # для ROC кривой
library(skimr) # описательные статистики (вместо psych в видеолекциях)
library(rio) # импорт файлов разных форматов
library(tidyverse) # графики и манипуляции с данными, подключаются пакеты dplyr, ggplot2, etc
library(tidymodels) # работа с моделями
library(huxtable) # таблички для нескольких моделей
library(precrec) # кривая точность - полнота
library(ROCit) # ROC кривая

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


tfull = augment(m_logit)
glimpse(tfull)

tfull2 = mutate(tfull,
      prob_hat = plogis(.fitted),
      surv_hat = (prob_hat > 0.5) * 1)
glimpse(tfull2)

table(tfull2$survived,
      tfull2$surv_hat)

mosaic(data = tfull2, ~ survived + surv_hat, shade = TRUE)


roc = rocit(score = tfull2$prob_hat,
            class = tfull2$survived)

qplot(x = roc$Cutoff,
      y = roc$TPR)
# TPR = TP / TP + FN
# чувствительность = полнота

qplot(x = roc$Cutoff,
      y = roc$FPR)
# FPR = FP / FP + TN
# 1 - FPR =специфичность

plot(roc)

ciAUC(roc)

precrec = evalmod(scores = tfull2$prob_hat,
                  labels = tfull2$survived)
autoplot(precrec)

# precision
# TP / TP + FP
