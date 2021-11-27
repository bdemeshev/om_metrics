library(tidyverse)

set.seed(777)
data = tibble(a = rnorm(10), b = rnorm(10))


data$c=factor(c(rep(1, 5), 2, 3, 1, 2, 2))
data

ggplot(data=data) + geom_point(size=4, aes(x=a, y=b, col=c, shape=c)) +
  labs(x='', y='') +
  scale_color_manual(values = c("1" = "black", "3" = "red", "2" = "blue")) +
  theme(legend.position="none")

