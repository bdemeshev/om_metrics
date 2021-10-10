# Esli russkie bukvi prevratilitis v krakozyabry, to File - Reopen with
# encoding... - UTF-8 - Set as default - OK

# lab 10-4

# подключаем пакеты
library(BoomSpikeSlab)
library(brms)
library(tidyverse)

#################################### Регрессия пик-плато (spike and slab regression)

h = mutate(cars, speed = 1.61 * speed,
           dist = 0.3 * dist)
h2 = mutate(h, speed2 = speed^2,
            junk = rnorm(nrow(h)))
h2

?cars

ols_a = lm(data = h2, dist ~ speed + junk)
summary(ols_a)

ols_b = lm(data = h2, dist ~ speed + speed2)
summary(ols_b)

bss_a = lm.spike(data = h2, dist ~ speed + junk,
           niter = 2000)

bss_a
betas = as_tibble(bss_a$beta)
betas

sum(betas$junk == 0) / 2000
sum(betas$speed == 0) / 2000


bss_b = lm.spike(data = h2, dist ~ speed + speed2,
                 niter = 2000)

bss_b
betas_b = as_tibble(bss_b$beta)
betas_b

sum(betas_b$speed == 0) / 2000
sum(betas_b$speed2 == 0) / 2000





