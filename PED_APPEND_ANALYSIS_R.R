library(readr)
library(dplyr)
library(tidyverse)
library(ggplot2)


append <- read.csv('ped_append.csv', header=TRUE)
View(append)


wbc <- append%>%select(WBC_Count)
View(wbc)
