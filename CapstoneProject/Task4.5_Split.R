#######################
### Task 4.5 Splitting ###
#######################
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

##################
## Test Predict ##
##################
load('Completed/Trigrams_completed.RData')

Trigram_all <- as.data.table(Trigram_all)
input <- 'how are'
system.time(predict <- Trigram_all[Trigram_all$terms == input, ])
system.time(predict <- match(input, Trigram_all$terms))
predict

###################
## Split Columns ##
###################
load('Completed/Quatrgrams_all_completed.RData') # 6231160
class(Quatrgrams_all$terms)
ngram_pred$terms <- as.character(ngram_pred$terms)
Quatrgrams_all <- as.data.table(Quatrgrams_all)
rm(ngram_pred)

Quatrgrams_all[,ngram:=strsplit(terms, '\\s')]
Quatrgrams_all[, `:=`(w1=sapply(ngram, function(s) s[1]),
                      w2=sapply(ngram, function(s) s[2]),
                      w3=sapply(ngram, function(s) s[3]),
                      w4=sapply(ngram, function(s) s[4]),
                      terms=NULL, ngram=NULL)]
Quatrgrams_all <- as.data.frame(Quatrgrams_all)

head(Quatrgrams_all); dim(Quatrgram_twitter_cleaned); object.size(Quatrgrams_all)

Quatrgram_blog_clean <- str_replace_all(Quatrgrams_all$w4, "[^a-z]", NA)
length(Quatrgram_blog_clean[is.na(Quatrgram_blog_clean)])
Quatrgram_twitter[is.na(Quatrgram_blog_clean),]
Quatrgram_twitter <- Quatrgram_twitter[!is.na(Quatrgram_blog_clean),]

Quatrgram_twitter_cleaned <- Quatrgrams_all[-which(Quatrgrams_all$freq_all == 1), ]

save(Quatrgrams_all, file='Completed/Quatrgrams_all_completed.RData')

##########################
## Probabilities Matrix ##
##########################
load('Completed/Trigrams_completed.RData')
head(Quatrgrams_twitter); dim(Quatrgrams_twitter); object.size(Quatrgrams_twitter)
Quatrgram_twitter_cleaned <- as.data.table(Quatrgram_twitter_cleaned)

Quatrgram_twitter_cleaned <- Quatrgram_twitter_cleaned[, `:=`(terms = paste(w1,w2,w3,w4,sep=' '), 
                                                              w1=NULL, w2=NULL, w3=NULL, w4=NULL)]
setnames(Trigram_all, c('freq', 'term'))
save(Quatrgrams_twitter, file='Completed/entire/Quatrgram_twitter_completed.RData')

# only keep top 10 of each term
vocabulary <- names(table(Trigram_all$term))
Trigram_all <- as.data.frame(Trigram_all)

Trigram_all_trimmed <- data.frame(freq=NULL,pred=NULL,term=NULL)

### predict time ###
setkeyv(Trigram_all, c( 'w1','w2','w3','freq'))
Trigram_all[list('how', 'are', 'you')]
system.time(a <- tail(Trigram_all[list('how are')]))