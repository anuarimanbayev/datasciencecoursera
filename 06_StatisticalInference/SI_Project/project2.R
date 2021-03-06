## =========================================================================================================================================== ##
## Now in the second portion of the class, we're going to analyze the ToothGrowth data in the R datasets package.

## 1. Load the ToothGrowth data and perform some basic exploratory data analyses
## 2. Provide a basic summary of the data.
## 3. Use confidence intervals and/or hypothesis tests to compare tooth growth by supp and dose. (Only use the techniques from class, even if there's other approaches worth considering)
## 4. State conclusions and the assumptions needed for conclusions.

## Evaluation Criteria:
##      - Exploratory data analysis of at least a single plot or table highlighting basic features of the data?
##      - Relevant confidence intervals and/or tests?
##      - Were the results of the tests and/or intervals interpreted in the context of the problem correctly?
##      - Describe the assumptions needed for conclusions?

## =========================================================================================================================================== ##

library(ggplot2)
library(knitr)
library(datasets)
library(gridExtra)
library(GGally)
opts_chunk$set(fig.width=10, fig.height=8, warning=FALSE, message=FALSE)

## =========================================================================================================================================== ##
## 1. Load the ToothGrowth data and perform some basic exploratory data analyses 
## Load dataset ToothGrowth

data(ToothGrowth)
# to keep camelCase naming format with lowercase first letter and uppercase subsequent letters
toothGrowth <- ToothGrowth
# convert to factor for plotting
toothGrowth$dose <- as.factor(toothGrowth$dose)

## Some basic exploratory data analyses 

str(toothGrowth)
head(toothGrowth)
tail(toothGrowth)

## Number of Rows and Columns.

dim(toothGrowth)

## Sample Size n

sample_size <- length(toothGrowth$len)
sample_size

## Mean group by dose and by OJ & VC

## X bar - Mean
mean_groups <- aggregate(toothGrowth$len,list(toothGrowth$supp,toothGrowth$dose),mean)
mean_groups

## Standard Deviation group by dose and by OJ & VC

## s - standard Deviation
sd_group <- aggregate(toothGrowth$len,list(toothGrowth$supp,toothGrowth$dose),sd)
sd_group

## =========================================================================================================================================== ##
## 2. Provide a basic summary of the data.

summary(toothGrowth)

## Table of data. 

table(toothGrowth$supp, toothGrowth$dose)

## Boxplots of data.
p1 <- ggplot(data=toothGrowth, aes(x=dose,y=len,fill=dose)) +
        geom_boxplot() + 
        theme(legend.position="none") + 
        facet_grid(.~supp) 

p2 <- ggplot(data=toothGrowth, aes(x=supp,y=len,fill=supp)) +
        geom_boxplot() + 
        theme(legend.position="none") + 
        facet_grid(.~dose) 

p3 <- ggplot(data=toothGrowth, aes(x=supp,y=len,fill=supp)) +
        geom_boxplot()

p4 <- ggplot(data=toothGrowth, aes(x=dose,y=len,fill=dose)) +
        geom_boxplot()

grid.arrange(p1, p4, p2, p3, ncol = 2, nrow=2, top="Boxplots of ToothGrowth Data by Vitamin C Dose and Supplement")

## =========================================================================================================================================== ##
## 3. Use confidence intervals and/or hypothesis tests to compare tooth growth by supp and dose. 
## (Only use the techniques from class, even if there's other approaches worth considering)

# Perform an Analysis of Variance (ANOVA)
anova.out <- aov(len ~ supp * dose, data=toothGrowth)
summary(anova.out)

# TukeyHSD Analysis of supp and dose groups
TukeyHSD(anova.out)
confint(anova.out)
print(model.tables(anova.out,"means"),digits=3)

## =========================================================================================================================================== ##
## 4. State your conclusions and the assumptions needed for your conclusions. 

## We conclude that the data indicates that both the dosage and the supplement have clear indepednent effects on the length growth or elongation of guinea pig teeth. Supplement type has demonstrated influence, but OJ has a greater average teeth growth in combination with dosages at 0.5 and 1 than for the VC supplement. However, at dosage level 2, there appears to be no significant effect (similar means and confidence intervals) between the VC supplement and the OJ.

## The above conclusions depend upon the following assumptions:
##      * the distribution of the means is approximately normal
##      * main predictors of dosage and supplement were randomly assigned
##      * the sample dataset population of guinea pigs is representative or generalizable to the general population of guinea pigs