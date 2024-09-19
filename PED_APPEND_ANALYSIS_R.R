library(readr)
library(dplyr)
library(tidyverse)
library(ggplot2)


append <- read.csv('ped_append.csv', header=TRUE)
View(append)


wbc <- append%>%select(WBC_Count)
View(wbc)

#testing quantitatively for a linear relationship by computing the correlation coefficient. 

coeff_1 <- cor.test(append$WBC_Count, append$Age)
coeff_1$estimate

#this demonstrates that there is a very low correlation, and therefore a weak linear relationship between these two variables.

coeff_2 <- cor.test(append$WBC_Count, append$Neutrophil_Percentage)
coeff_2$estimate

#the value 0.6634112 demonstrates a greater linear linear relationship than is demonstrated in coeff_1. 

str(append)


WBC_dist <- append%>%ggplot(aes(WBC_Count)) + geom_bar()
WBC_dist


#check for outliers in the WBC distribution

plot <- append%>%ggplot(aes(WBC_Count, WBC_Count)) + geom_boxplot()
plot


