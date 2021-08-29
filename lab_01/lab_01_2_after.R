library(tidyverse) # графики + манипуляции с данными...

x = c(160, 170, 180, 156)
y = c(12, 14, 11, 15)

short_run = tibble(rost = x, time100m = y)
short_run

short_run$rost
short_run[, 1]

short_run[2, ]


short_run[2, 1]

chulan = list(a = 7, v = 10:100, tbl = short_run)
short_run


chulan

chulan$tbl

chulan[[2]]

chulan$a


