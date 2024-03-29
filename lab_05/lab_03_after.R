# if you see KRAKOZYABRY then do 'File' - 'Reopen with encoding' - 'UTF-8' - 
# (Set as default) - OK

# lab 3

# подключаем пакеты
library(memisc) # две и более регрессий в одной табличке
library(skimr) # описательные статистики (вместо psych в видеолекциях)
library(lmtest) # тестирование гипотез в линейных моделях
library(rio) # загрузка данных в разных форматах (вместо foreign в видеолекциях)
library(vcd) # мозаичные графики
library(hexbin) # графики
library(sjPlot) # визуализация результатов регрессии
library(tidyverse) # графики и манипуляции с данными, подключаются пакеты dplyr, ggplot2, etc

# помещаем встроенный набор данных по бриллиантам в табличку h
h <- diamonds
glimpse(h)
help(diamonds)

# диаграмма рассеяния:
qplot(data = h, carat, price)
bg <- qplot(data = h, log(carat), log(price))
bg + geom_hex()  # диаграмма рассеяния и шестиугольники плотности

# загружаем данные по стоимости квартир в Москве 
# предварительно нужно установить рабочую папку:
# Session — Set working directory — To source file location
f <- import("flats_moscow.txt")

glimpse(f)  # краткое содержимое таблички f
qplot(data = f, totsp, price)  # диаграмма рассеяния
str(f)  # структура таблички f
qplot(data = f, log(totsp), log(price))  # диаграмма рассеяния в логарифмах

# мозаичный график
mosaic(data = f, ~walk + brick + floor, shade = TRUE)

# преобразуем переменны walk, brick, floor, code в факторные
f <- mutate_at(f, vars(walk, brick, floor, code), factor)
glimpse(f)  # краткое содержимое таблички f

qplot(data = f, log(price))  # гистограмма

# гистограмма для кирпичных и некирпичных домов
qplot(data = f, log(price), fill = brick)  # вариант А
ggplot(data = f, aes(log(price), fill = brick)) +
  geom_histogram(position = "dodge") # вариант Б с большими возможностями настройки

# оцененные функции плотности
qplot(data = f, log(price), fill = brick, geom = "density")

# добавляем прозрачность
g2 <- qplot(data = f, log(price), fill = brick, geom = "density", alpha = 0.5)

# несколько графиков получаемых путем видоизменения графика g2
g2 + facet_grid(walk ~ floor)
g2 + facet_grid(~floor)

# оценим три модели
model_0 <- lm(data = f, log(price) ~ log(totsp))
model_1 <- lm(data = f, log(price) ~ log(totsp) + brick)
model_2 <- lm(data = f, log(price) ~ log(totsp) + brick + brick:log(totsp))
# двоеточие в формуле модели в R — произведение регрессоров

summary(model_0)  # базовый вариант отчета о модели
mtable(model_2)  # альтернативный вариант отчета


model_2b <- lm(data = f, log(price) ~ brick * log(totsp))
# умножение в формуле модели в R --- сами регрессоры и их произведение

# сравнение двух моделей
mtable(model_2, model_2b)
# сделаем huxreg()


# оценки коэффициентов визуально
plot_model(model_2)

# создаем новый набор данных для прогнозирования
nw <- data.frame(totsp = c(60, 60), brick = factor(c(1, 0)))
nw

# точечный прогноз логарифма цены
predict(model_2, newdata = nw)
# переходим от логарифма к цене
exp(predict(model_2, newdata = nw))

# доверительный интервал для среднего значения y
predict(model_2, newdata = nw, interval = "confidence")  # для логарифма
exp(predict(model_2, newdata = nw, interval = "confidence"))  # для исходной переменной

# предиктивный интервал для конкретного значения y
predict(model_2, newdata = nw, interval = "prediction")
exp(predict(model_2, newdata = nw, interval = "prediction"))


# F-тест
waldtest(model_0, model_1)  # H_0: model_0 H_a: model_1
# H_0 отвергается

waldtest(model_1, model_2)  # H_0: model_1 H_a: model_2
# H_0 отвергается

waldtest(model_0, model_2)  # # H_0: model_0 H_a: model_2
# H_0 отвергается


# добавляем линию регрессии на диаграмму рассеяния
gg0 <- qplot(data = f, log(totsp), log(price))
gg0 + stat_smooth(method = "lm")
gg0 + stat_smooth(method = "lm") + facet_grid(~walk)
gg0 + aes(col = brick) + stat_smooth(method = "lm") + facet_grid(~walk)

# по-другому зададим дамми переменную
f$nonbrick <- memisc::recode(f$brick, 1 <- 0, 0 <- 1)
glimpse(f)

# сознательно попробуем попасть в ловушку дамми-переменных
model_wrong <- lm(data = f, log(price) ~ log(totsp) + brick + nonbrick)
summary(model_wrong)

# сравним три модели в одной табличке:
mtable(model_0, model_1, model_2)

# тест Рамсея
resettest(model_2)







---
title: "Нано презентация"
subtitle: "⚔<br/>с помощью xaringan"
author: "Винни-Пух"
output:
  xaringan::moon_reader:
    lib_dir: libs
    nature:
      highlightStyle: github
      highlightLines: true
      countIncrementalSlides: false
---


```{r setup, include=FALSE}
options(htmltools.dir.version = FALSE)
```

исследовании мы рассмотрим цены на квартиры в Москве.


```{r, include=FALSE}
library(huxtable) # перевод табличек в markdown, tex, html, word...
library(tidyverse) # коллекция, куда входят dplyr, ggplot2, ...
library(pander) # перевод разных объектов в маркдаун
library(knitr) # настройки обработки кусков кода
library(rio) # чтение файлов разных форматов
f <- import("flats_moscow.txt")
opts_chunk$set(echo = FALSE, message = FALSE)
```

В нашем наборе данных `r nrow(f)` наблюдений. Средняя цена квартиры равна `r round(mean(f$price), 0)` тысяч у.е.

---

Распределение цен квартир в кирпичных и некирпичных домах:

```{r}
# синтаксис mutate_each из видео устарел :)
# у mutate_at аргументы: табличка, названия переменных, функция
f <- mutate_at(f, c("walk", "brick", "floor", "code"), factor)
ggplot(data = f, aes(log(price), fill = brick)) +
  geom_histogram(position = "dodge")
```

---

### Оценим и сравним три модели:

```{r, results='asis', warning=FALSE}
model_0 <- lm(data = f, log(price) ~ log(totsp))
model_1 <- lm(data = f, log(price) ~ log(totsp) + brick)
model_2 <- lm(data = f, log(price) ~ log(totsp) + brick + brick:log(totsp))

reg_table <- huxreg(model_0, model_1, model_2, note = NULL)
print_html(reg_table)
```

У нас лучше оказалась модель 2.

---
