library(tidyverse)
library(caret)
library(rio)
library(skimr)
library(expm)

flats = import('flats_moscow.txt')
glimpse(flats)

flats = select(flats, -n, -code)

set.seed(777)
intrain = createDataPartition(y = flats$price, p = 0.8, list = FALSE)
training = flats[intrain,]
testing = flats[-intrain,]

train_params = trainControl(method = "repeatedcv",
                            number = 10,
                            repeats = 3)
set.seed(777)
knn_fit <- train(price ~ ., data = training, method = "knn",
                 trControl  = train_params,
                 preProcess = c("center", "scale"),
                 tuneLength = 5)
knn_fit
predict(knn_fit, testing)

reg_fit = train(price ~ ., data = training, method = "lm",
                         trControl  = train_params,
                         preProcess = c("center", "scale"))

reg_fit
glimpse(flats)


library(tidyverse)
library(MatchIt)
library(optmatch)
library(lmtest)
library(sandwich)
data(lalonde)

head(lalonde)

match_obj <- matchit(treat ~ age + educ + race + married +
                    nodegree + re74 + re75, data = lalonde,
                    method = "full", estimand = "ATE")
match_obj
summary(match_obj)
match_df <- match.data(match_obj)
glimpse(match_df)
glimpse(lalonde)
unique(match_df$subclass)


fit <- lm(re78 ~ treat + age + educ + race + married + nodegree +
             re74 + re75, data = match_df, weights = weights)

coeftest(fit, vcov. = vcovCL, cluster = ~subclass)


fit_naive = lm(data = lalonde, re78 ~ treat + age + educ + race + married + nodegree + re74 + re75)
coeftest(fit_naive, vcov. = vcovHC)
