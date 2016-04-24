## =========================================================================================================================================== ##
## Data Science Specialization Capstone Project
## Task 5: Creative Exploration
## by Anuar Imanbayev

## So far you have used basic models to understand and predict words. In this next task, your goal is to use all 
## the resources you have available to you (from the Data Science Specialization, resources on the web, or your own 
## creativity) to improve the predictive accuracy while reducing computational runtime and model complexity (if you can). 
## Be sure to hold out a test set to evaluate the new, more creative models you are building.

## Tasks to Accomplish
## 1. Explore new models and data to improve your predictive model.
## 2. Evaluate your new predictions on both accuracy and efficiency. 

## Questions to Consider
## 1. What are some alternative data sets you could consider using? 
## 2. What are ways in which the n-gram model may be inefficient?
## 3. What are the most commonly missed n-grams? Can you think of a reason why they would be missed and fix that? 
## 4. What are some other things that other people have tried to improve their model? 
## 5. Can you estimate how uncertain you are about the words you are predicting?
## =========================================================================================================================================== ##

# Setting up java development kit for rJava
#Sys.setenv(JAVA_HOME="C:\\Program Files (x86)\\Java\\jre1.8.0_91\\")
Sys.setenv(JAVA_HOME="C:\\Program Files (x86)\\Java\\jdk_8u91_windows_x64\\")
library(rJava)
# Increasing heap size
options( java.parameters = "-Xmx8000m" )
#options(java.parameters = "-Xmx8g")
projectPath <- 'C:/Users/Anuar Imanbayev/Desktop/DataScienceCourse/DSC_Working_Directory/CapstoneProject/CapstoneProject_ShinyApp'
setwd(projectPath)

rm(list=ls(all=TRUE));gc(reset=TRUE);par(mfrow=c(1,1))
require(tm); require(SnowballC); require(stringr);require(RWeka); 
require(qdap); require(scales); require(gridExtra); require(data.table)

load('Completed/nGrams_model.RData') 
source('funcPredictNextWord.R')

## make prediction
input <- "me about his"
system.time(result <- predictNextWord(input))
result
Quatrgrams_model[list('me', 'about', 'his')]

object.size(Quatrgrams_model)/1024/1024; dim(Quatrgrams_model);head(Quatrgrams_model)
Bigrams_model <- Bigrams_all[-which(Bigrams_all$freq==2),]
Trigrams_model <- Trigram_all[-which(Trigram_all$freq==2),]
Quatrgrams_model <- Quatrgrams_all[-which(Quatrgrams_all$freq==2),]
Unigrams_model <- Unigrams_all[1:6,]
save(Unigrams_model, Bigrams_model, Trigrams_model, Quatrgrams_model,
     file='Completed/nGrams_model.RData')