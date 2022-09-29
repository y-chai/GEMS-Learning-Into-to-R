# Title: Data Analysis Workflow
# Name: YC
# Date: 2022-09-29
# Description: GEMSX004 Intro to R example R script file, demonstrating a typical data analysis workflow

# Clean workspace ----------
rm(list=ls())

# Load packages ----------
library(stargazer)

# Import data ----------
## import from .csv files
dat_farm <- read.csv("./data/dat_farm.csv")
## Preview data
head(dat_farm)

# Create new variables ----------
## create a new variable which is the sqaured NPK
dat_farm$NPKsq <- (dat_farm$NPK)^2

## preview data
head(dat_farm)

# Summary statistics ----------
## dataframe structure
str(dat_farm)

## summary statistics
summary(dat_farm)

## Calculate mean and standard deviations for a single variable
mean(dat_farm$Yield)
sd(dat_farm$Yield)

## Use the stargazer function to generate well-formated summary statistics
stargazer(dat_farm, type = "text", title="Descriptive statisics", digits=2)

# Simple plots ----------
## Histogram
hist(dat_farm$Yield)

## Change the number of bins in the histogram
hist(dat_farm$Yield, breaks = 10)

## Scatterplot
plot(x = dat_farm$NPK, y=dat_farm$Yield)

# Simple regression ----------

## OLS: yield ~ fertilizer
ols_fert1 <- lm(Yield ~ NPK, data=dat_farm)
summary(ols_fert1)

## OLS: yield ~ fertilizer + fertilizer^2
ols_fert2 <- lm(Yield ~ NPK + NPKsq, data=dat_farm)
summary(ols_fert2)

## OLS: yield ~ fertilizer + fertilizer^2 + tractor
ols_fert3 <- lm(Yield ~ NPK + NPKsq + Tractor, data=dat_farm)
summary(ols_fert3)

## Comparison of models ----------
anova(ols_fert1, ols_fert2, ols_fert3)

# Export results ----------

## Write data to csv file
write.csv(dat_farm, file="./data/02_dat_farm_v2.csv")

## Data summary statistics
stargazer(dat_farm, type = "text", title="Descriptive statisics", digits=2, out="./results/02_summary_stat.txt")

## Regression results
stargazer(ols_fert1, ols_fert2, ols_fert3, type = "text", digits=2, out="./results/02_ols.txt")