library(tidyverse)
library(MatchIt)
library(optmatch)
library(lmtest)
library(sandwich)

data(lalonde)
glimpse(lalonde)

match_obj = matchit(data = lalonde,
  treat ~ age + educ + race + married + nodegree +
    re74 + re75,
  method = 'full', estimand = 'ATE')
match_obj

match_df = match.data(match_obj)
glimpse(match_df)

unique(match_df$subclass)

summary(match_obj)


fit = lm(re78 ~ treat + age + educ + race + married + nodegree +
           re74 + re75, data = match_df,
         weights = weights)

coeftest(fit, vcov. = vcovCL, cluster = ~subclass)


fit_naive = lm(re78 ~ treat + age + educ + race + married + nodegree +
           re74 + re75, data = lalonde)
coeftest(fit_naive, vcov. = vcovHC)



