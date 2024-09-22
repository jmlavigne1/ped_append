library(readr)
library(dplyr)
library(tidyverse)
library(ggplot2)


append <- read.csv('ped_append.csv', header=TRUE)
View(append)
nrow(append)
wbc <- append%>%select(WBC_Count)
View(wbc)

#clean the data to remove the NA values for WBC count, RBC Count, and Neutrophil %
wbc <- na.omit(wbc)
nrow(wbc)

rbc <- append%>%select(RBC_Count)
nrow(rbc)
rbc <- na.omit(rbc)
nrow(rbc)

np <- append%>%select(Neutrophil_Percentage)
nrow(np)
np <- na.omit(np)
nrow(np)
 
# the np sub dataframe is 776 - 679 rows smaller than the wbc sub dataframe, so I will join these two dataframes. 




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

threshold = 32
wbc_clean <- append%>%filter(WBC_Count < threshold)

plot_2 <- wbc_clean%>%ggplot(aes(WBC_Count,WBC_Count)) + geom_boxplot() +ggtitle("WBC Count Boxplot")
plot_2


##building a simple linear model
#splitting the data 60/40

sample <-sample(c(TRUE, FALSE), nrow(wbc_clean),replace =T, prob= c(0.6, 0.4))
#subset data points into train and test set
train <- wbc_clean[sample, ]
test <- wbc_clean[!sample, ]

#build the linear model

model <- lm(Neutrophil_Percentage ~ WBC_Count, data=train)

#quantify the model fit
#calculating the Residual Standard Error (RSE)
summary(model)
sigma(model)
#these are two modes of generating the RSE


#calculating the r^2 statistic represents the proportion of variance explained. 
summary(model)$r.squared
#our r^2 value is 0.4626656.This suggests taht we have 46% variability in the total wbc count value.


#to quantify in comparison the model fit to other models, I will build a second model

model_2 <- lm(Neutrophil_Percentage ~ RBC_Count, data=train)
model_2

r_sq_2 <- summary(model_2)$r.squared
r_sq_2
r_sq <- summary(model)$r.squared
r_sq

##checking model residuals

train$estimate <- predict(model)
train$residuals <- residuals(model)

length(resid(lm(Neutrophil_Percentage ~ RBC_Count, test)))

length(resid(lm(Neutrophil_Percentage ~ WBC_Count, test)))
nrow(test)


