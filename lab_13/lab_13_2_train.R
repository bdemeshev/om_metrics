library(tidyverse) # манипуляции с данными
library(skimr) # описательные статистики
library(tidymodels) # удобства для оценивания моделей
library(sjPlot) # визуализация коэффициентов
library(car) # проверка сложных гипотез
library(lmtest) # тесты для моделей
library(texreg) # таблички для сравнения моделей
library(rio) # import / export всех форматов
library(sjlabelled) # работа с мечеными переменными
library(boot) # бутстрэп
library(sandwich) # HC оценки дисперсии оценок коэффициентов
library(lmboot) # бутстрэп коэффициентов
library(car) # ещё немного бутстрэпа для регрессии


d = cars

mod_zero = lm(cars, formula = 'dist ~ speed')
y_hat = fitted(mod_zero)
scaled_residuals = resid(mod_zero)  / sqrt(1 - hatvalues(mod_zero))

get_boot_coef = function(df, indices,
                         y_hat, scaled_residuals) {
  # v_star = sample(c(-1, 1), size = nrow(df), replace = TRUE)
  v_star = rnorm(nrow(df))
  df['y_star'] = y_hat + scaled_residuals * v_star

  boot_ols = lm(data = df, formula = 'y_star ~ speed')
  boot_coef = coef(boot_ols)
  boot_se = diag(vcov(boot_ols))

  return(c(boot_coef, boot_se))
}

set.seed(777)
boot_coefs = boot(cars, get_boot_coef, R=1000,
                  y_hat = y_hat,
                  scaled_residuals = scaled_residuals)
boot_coefs$t
# bias = difference bootstrap mean vs original
boot.ci(boot_coefs, type = 'basic', index = 1)
boot.ci(boot_coefs, type = 'stud', index = c(1, 3))
boot.ci(boot_coefs, type = 'basic', index = 2)
boot.ci(boot_coefs, type = 'stud', index = c(2, 4))

confint(mod_zero)

pairs_boot <- Boot(mod_zero, R = 1000)
summary(pairs_boot)
confint(pairs_boot, type = 'basic')
confint(pairs_boot, type = 'bca')

hist(pairs_boot)

library(lmboot)
?wild.boot


wild_boot <- wild.boot(data=cars, dist ~ speed, B=1000, seed=777) #perform the wild bootstrap

wild_boot$bootEstParam

#bootstrap 95% CI for slope parameter (percentile method)
betas_boot = wild_boot$bootEstParam[, 2]
quantile(betas_boot, probs = c(.025, .975))


paired_boot <- paired.boot(data=cars, dist ~ speed, B=1000, seed=777) #perform the wild bootstrap
betas_boot = paired_boot$bootEstParam[, 2]
quantile(betas_boot, probs = c(.025, .975))



pairs_boot <- Boot(mod_zero, R = 1000)
summary(pairs_boot)
confint(pairs_boot, type = 'basic')
confint(pairs_boot, type = 'bca')

