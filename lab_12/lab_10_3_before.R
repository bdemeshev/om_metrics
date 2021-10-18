# Esli russkie bukvi prevratilitis v krakozyabry, to File - Reopen with
# encoding... - UTF-8 - Set as default - OK

# lab 10-3

# подключаем пакеты
library(BoomSpikeSlab)
library(brms)
library(tidyverse)

#################################### Байесовский подход: логит-модель

bad = tibble(y = c(0, 0, 1), x = 1:3)
bad

logit_0 = glm(data = bad,
              y ~ x,
              family = binomial(link = 'logit'))
summary(logit_0)

b_logit_0 = brm(data = bad,
                y ~ x,
                family = bernoulli(link = 'logit'),
                chains = 2,
                iter = 2000,
                warmup = 500,
                seed = 777,
                cores = 2)

b_logit_0
stanplot(b_logit_0)
stanplot(b_logit_0, type = 'trace')
stanplot(b_logit_0, type = 'hist')

get_prior(data = bad,
          y ~ x,
          family = bernoulli(link = 'logit'))

b_prior = prior(normal(0, 10), class = 'b')

b_logit_1 = brm(data = bad,
                y ~ x,
                family = bernoulli(link = 'logit'),
                chains = 2,
                iter = 2000,
                warmup = 500,
                seed = 777,
                cores = 2,
                prior = b_prior)

b_logit_1
stanplot(b_logit_1)
stanplot(b_logit_1, type = 'trace')
stanplot(b_logit_1, type = 'hist')

