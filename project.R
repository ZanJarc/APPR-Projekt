library(dplyr)
library(ggplot2)

data <- read.csv("avtomobili.csv", encoding = "UTF-8")

data <- data[,c(1:7)]

data$celo_ime <- paste(data$znamka, data$ime, sep=" ")

stetje_modelov <-data %>% count(data$celo_ime, sort = TRUE)

ggplot(stetje_modelovc, aes(x = stetje_modelov$`data$celo_ime`, y = stetje_modelov$n)) +
  geom_point()
