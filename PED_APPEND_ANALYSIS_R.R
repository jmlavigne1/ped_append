gc()

library(tidyverse)
append <- read.csv('ped_append.csv', header=TRUE)
append <- tibble::rowid_to_column(append, "ID")
View(append)

#clean the data
wbc <- append%>%select(WBC_Count, ID)
wbc <- na.omit(wbc)
rbc <- append%>%select(RBC_Count, ID)
rbc <- na.omit(rbc)
np <- append%>%select(Neutrophil_Percentage, ID)
np <- na.omit(np)

wbc_np <- left_join(np, wbc)
View(wbc_np)
whole <- inner_join(wbc_np, rbc)

#testing quantitatively for a linear relationship by computing the correlation coefficient. 

coeff_1 <- cor.test(append$WBC_Count, append$Age)
print(coeff_1$estimate)

#this demonstrates that there is a very low correlation, and therefore a weak linear relationship between these two variables.

coeff_2 <- cor.test(whole$Neutrophil_Percentage, whole$WBC_Count)
coeff_2$estimate

#the value 0.6634112 demonstrates a greater linear linear relationship than is demonstrated in coeff_1. 

coeff_3 <- cor.test(whole$Neutrophil_Percentage, whole$RBC_Count)
coeff_3$estimate

#coeff_3 returns a value of the 0.006627787 that indicates that there is a low correlation.

str(append)


WBC_dist <- append%>%ggplot(aes(WBC_Count)) + geom_bar()
WBC_dist


#check for outliers in the WBC distribution

plot <- whole%>%ggplot(aes(WBC_Count, WBC_Count)) + geom_boxplot()
plot

threshold = 32
wbc_clean <- whole%>%filter(WBC_Count < threshold)

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
#our r^2 value is 0.4780326.This suggests that we have 47 - 48% variability in the total wbc count value.


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

summary(model)

summary(model_2)
#visualize the fit

ggplot(train, aes(Neutrophil_Percentage, WBC_Count)) +
  geom_point() +
  geom_smooth(method = "lm") +
  geom_smooth(se = FALSE, color = "red") 

ggplot(train, aes(Neutrophil_Percentage, RBC_Count)) +
  geom_point() +
  geom_smooth(method = "lm") +
  geom_smooth(se = FALSE, color = "red") 


# build a multiple linear model

model_3 <-  lm(Neutrophil_Percentage ~ RBC_Count + WBC_Count, data=train)
model_3


summary(model_3)
