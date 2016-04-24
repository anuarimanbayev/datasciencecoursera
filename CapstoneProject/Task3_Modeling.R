## =========================================================================================================================================== ##
## Data Science Specialization Capstone Project
## Task 3: Prediction Model
## by Anuar Imanbayev

## The goal here is to build your first simple model for the relationship between words. This is the first step in 
## building a predictive text mining application. You will explore simple models and discover more complicated modeling techniques.

## Tasks to Accomplish
## 1. Build basic n-gram model - using the exploratory analysis you performed, build a basic n-gram model for predicting the next word based on the previous 1, 2, or 3 words.
## 2. Build a model to handle unseen n-grams - in some cases people will want to type a combination of words that does not appear in the corpora. Build a model to handle cases where a particular n-gram isn't observed.

## Questions to Consider
## 1. How can you efficiently store an n-gram model (think Markov Chains)?
## 2. How can you use the knowledge about word frequencies to make your model smaller and more efficient?
## 3. How many parameters do you need (i.e. how big is n in your n-gram model)?
## 4. Can you think of simple ways to "smooth" the probabilities (think about giving all n-grams a non-zero probability even if they aren't observed in the data) ?
## 5. How do you evaluate whether your model is any good?
## 6. How can you use backoff models to estimate the probability of unobserved n-grams?

## Hints, tips, and tricks
## As you develop your prediction model, two key aspects that you will have to keep in mind are the size and runtime of the algorithm. These are defined as:
## Size: the amount of memory (physical RAM) required to run the model in R
## Runtime: The amount of time the algorithm takes to make a prediction given the acceptable input
## Your goal for this prediction model is to minimize both the size and runtime of the model in order to provide a reasonable experience to the user.

## Keep in mind that currently available predictive text models can run on mobile phones, which typically have limited memory and processing power compared to desktop computers. Therefore, you should consider very carefully (1) how much memory is being used by the objects in your workspace; and (2) how much time it is taking to run your model. Ultimately, your model will need to run in a Shiny app that runs on the shinyapps.io server.

## Here are a few tools that may be of use to you as you work on their algorithm:
## object.size(): this function reports the number of bytes that an R object occupies in memory
## Rprof(): this function runs the profiler in R that can be used to determine where bottlenecks in your function may exist. The profr package (available on CRAN) provides some additional tools for visualizing and summarizing profiling data.
## gc(): this function runs the garbage collector to retrieve unused RAM for R. In the process it tells you how much memory is currently being used by R.
## There will likely be a tradeoff that you have to make in between size and runtime. 
## For example, an algorithm that requires a lot of memory, may run faster, while a slower algorithm may require less memory. You will have to find the right balance between the two in order to provide a good experience to the user.

## =========================================================================================================================================== ##

#Sys.setenv(JAVA_HOME="C:\\Program Files (x86)\\Java\\jre1.8.0_91\\")
Sys.setenv(JAVA_HOME="C:\\Program Files (x86)\\Java\\jdk_8u91_windows_x64\\")
## Increasing Java Heap Size to 8GB of RAM memory
library(rJava)
options( java.parameters = "-Xmx8000m" )
#options(java.parameters = "-Xmx8g")
projectPath <- 'C:/Users/Anuar Imanbayev/Desktop/DataScienceCourse/DSC_Working_Directory/CapstoneProject/CapstoneProject_ShinyApp'
setwd(projectPath)
rm(list=ls(all=TRUE));gc(reset=TRUE);par(mfrow=c(1,1))

## Loading dependencies
require(tm); require(SnowballC); require(data.table); require(stringr)
require(ggplot2); require(RWeka); require(qdap);
require(scales); require(gridExtra); require(wordcloud)

##################
### Get Corpus ###
##################
en_US <- file.path('.','final','en_US')
en_US_corpus <- Corpus(DirSource(en_US, encoding="UTF-8"), 
                       readerControl = list(reader = readPlain,language = "en_US",load = TRUE))
blog_corpus <- en_US_corpus[1]
news_corpus <- en_US_corpus[2]
twitter_corpus <- en_US_corpus[3]
# writeCorpus
save(blog_corpus, file='Corpus/blog_corpus.RData')
save(news_corpus, file='Corpus/news_corpus.RData')
save(twitter_corpus, file='Corpus/twitter_corpus.RData')
object.size(en_US_corpus); gc()

###############################
### Tokenization & Stemming ###
###############################
## ========================================================== ##
#load('data_18_Nov_2014/Corpus/blog_corpus.RData')
source('funcTokenization.R')
## ========================================================== ##

trans <- c(F,T,T,T,F,F,T,T)
ChartoSpace <- c('/','\\|')
stopWords <- 'english'
ownStopWords <- c()
swearwords <- read.table('profanityFilter/en.txt', sep='\n')
names(swearwords)<-'swearwords'
filter <- rep('***', length(swearwords))
profanity <- data.frame(swearwords, target = filter)
profanity <- rbind(profanity, data.frame(swearwords = c("[^[:alpha:][:space:]']","â ","ã","ð"), target = c(" ","'","'","'")))

## ========================================================== ##
tokenized_blog <- tokenization(blog_corpus, trans, ChartoSpace,
                               stopWords, ownStopWords, profanity)
tokenized_news <- tokenization(news_corpus, trans, ChartoSpace,
                               stopWords, ownStopWords, profanity)
tokenized_twitter <- tokenization(twitter_corpus, trans, ChartoSpace,
                                  stopWords, ownStopWords, profanity)
## ========================================================== ##
save(tokenized_blog, file='Tokenized/blog_tokenized.RData')
save(tokenized_news, file='Tokenized/news_tokenized.RData')
save(tokenized_twitter, file='Tokenized/twitter_tokenized.RData')

# stem_blog <- tm_map(tokenized_blog, stemDocument, 'english') # SnowballStemmer
# stem_news <- tm_map(tokenized_news, stemDocument, 'english') # SnowballStemmer
# stem_twitter <- tm_map(tokenized_twitter, stemDocument, 'english') # SnowballStemmer
# save(stem_blog, file='Stemmed/blog_stemmed.RData')
# save(stem_news, file='Stemmed/news_stemmed.RData')
# save(stem_twitter, file='Stemmed/twitter_stemmed.RData')


##############################
### Transfer to Data Frame ###
##############################
#load('Tokenized/blog_tokenized.RData')
#load('Tokenized/news_tokenized.RData')
#load('Tokenized/twitter_tokenized.RData')

stem_df_blog <- data.frame(text=unlist(sapply(tokenized_blog, '[',"content")),stringsAsFactors=F)
stem_df_news <- data.frame(text=unlist(sapply(tokenized_news, '[',"content")),stringsAsFactors=F)
stem_df_twitter <- data.frame(text=unlist(sapply(tokenized_twitter, '[',"content")),stringsAsFactors=F)
save(stem_df_blog, file='DataFrames/blog_df.RData')
save(stem_df_news, file='DataFrames/news_df.RData')
save(stem_df_twitter, file='DataFrames/twitter_df.RData')

################################
## Chunks Spliting for Ngrams ##
################################
rm(list=ls(all=TRUE));gc(reset=TRUE);par(mfrow=c(1,1))
## ========================================================== ##
load('DataFrames/blog_df.RData')
load('DataFrames/news_df.RData')
load('DataFrames/twitter_df.RData')
source('funcNGramSplit.R')
## ========================================================== ##

split_num <- 100
grams <- 1  # 1/2/3/4
## ========================================================== ##
ngram_pred <- nGramSplit(split_num, stem_df_blog, grams)
ngram_pred <- nGramSplit(split_num, stem_df_news, grams)
ngram_pred <- nGramSplit(split_num, stem_df_twitter, grams)
## ========================================================== ##
dim(ngram_pred)
round(object.size(ngram_pred),0)

# Blog
save(ngram_pred, file='NGrams/blog_Unigrams.RData')
save(ngram_pred, file='NGrams/blog_Bigrams.RData')
save(ngram_pred, file='NGrams/blog_Trigrams.RData')
save(ngram_pred, file='NGrams/blog_Quatrgrams.RData')

# News
save(ngram_pred, file='NGrams/news_Unigrams.RData')
save(ngram_pred, file='NGrams/news_Bigrams.RData')
save(ngram_pred, file='NGrams/news_Trigrams.RData')
save(ngram_pred, file='NGrams/news_Quatrgrams.RData')

# Twitter
save(ngram_pred, file='NGrams/twitter_Unigrams.RData')
save(ngram_pred, file='NGrams/twitter_Bigrams.RData')
save(ngram_pred, file='NGrams/twitter_Trigrams.RData')
save(ngram_pred, file='NGrams/twitter_Quatrgrams.RData')


#########################
## Combine Three Files ##
#########################
load('NGrams/split/blog_Trigrams.RData')
blog_Unigrams<-ngram_pred
dim(blog_Unigrams)
load('NGrams/split/news_Trigrams.RData')
news_Unigrams<-ngram_pred
dim(news_Unigrams)
load('NGrams/split/twitter_Trigrams.RData')
twitter_Unigrams<-ngram_pred
dim(twitter_Unigrams)

rm(ngram_pred)

load('Completed/Quatrgram_blog_completed.RData')
load('Completed/Quatrgram_news_completed.RData')
load('Completed/Quatrgram_twitter_completed.RData')

dim(Quatrgram_blog_cleaned);dim(Quatrgram_news_cleaned);dim(Quatrgram_twitter_cleaned);
cbind(head(Quatrgram_blog_cleaned), head(Quatrgram_news_cleaned), head(Quatrgram_twitter_cleaned))
Quatrgrams_all <- merge.data.frame(x = Quatrgram_blog_cleaned,y = Quatrgram_news_cleaned, by = 'terms', all = T)
Quatrgrams_all <- merge.data.frame(x = Quatrgrams_all,y = Quatrgram_twitter_cleaned, by = 'terms',all = T)
Quatrgrams_all[is.na(Quatrgrams_all)]<-0
Quatrgrams_all$freq_all <- Quatrgrams_all[,2] + Quatrgrams_all[,3] + Quatrgrams_all[,4]
Quatrgrams_all$freq.x <- NULL
Quatrgrams_all$freq.y <- NULL
Quatrgrams_all$freq <- NULL
Quatrgrams_all <- Quatrgrams_all[order(Quatrgrams_all$freq_all,decreasing = T),]
head(Quatrgrams_all, 20)
dim(Quatrgrams_all)
round(object.size(Quatrgrams_all),0)

save(Quatrgrams_all, file='Completed/Quatrgrams_all_completed.RData')

######################
## Ngrams Cleansing ##
######################
require(stringr)
rm(list=ls(all=TRUE));gc(reset=TRUE);par(mfrow=c(1,1))
load('NGrams/Unigrams_All.RData')
load('NGrams/Bigrams_All.RData')
load('NGrams/Trigrams_All.RData')
load('NGrams/Quatrgrams_All.RData')

dim(Unigrams_all)
# [^a-z]
# [^a-z][:blank:][^a-z]
# [^a-z][:blank:][^a-z][:blank:][^a-z]
cbind(head(Unigrams_all, 50),tail(Unigrams_all, 50))
Unigrams_all_unicode <- str_replace_all(Unigrams_all[,1], "[^a-z][:blank:][^a-z]", NA)
length(Unigrams_all_unicode[is.na(Unigrams_all_unicode)])

# Unigram
Unigrams_all_cleaned <- Unigrams_all[!is.na(Unigrams_all_unicode),]
Unigrams_all_dirt <- Unigrams_all[is.na(Unigrams_all_unicode),]
dim(Unigrams_all_cleaned); head(Unigrams_all_cleaned)
Unigrams_all_cleaned <- Unigrams_all_cleaned[1:10,]
# Bigram
Bigrams_all_cleaned <- Unigrams_all[!is.na(Unigrams_all_unicode),]
Bigrams_all_dirt <- Unigrams_all[is.na(Unigrams_all_unicode),]
dim(Bigrams_all_cleaned); head(Bigrams_all_cleaned)
### Trigram ###
load('NGrams/split/twitter_Trigrams.RData')
dim(ngram_pred)
cbind(head(ngram_pred, 50),tail(ngram_pred, 50))
Unigrams_all_unicode <- str_replace_all(Unigrams_all[,1], "[^a-z][:blank:][^a-z][:blank:][^a-z]", NA)
length(Unigrams_all_unicode[is.na(Unigrams_all_unicode)])

Trigrams_twitter_cleaned <- ngram_pred[!is.na(Unigrams_all_unicode),]
Trigrams_twitter_dirt <- Unigrams_all[is.na(Unigrams_all_unicode),]
dim(Trigrams_twitter_cleaned); head(Trigrams_twitter_cleaned)

save(Trigrams_twitter_cleaned, file='NGrams/Trigrams_twitter_cleaned.RData')

?regex
?regexpr

save(Unigrams_all_cleaned, file='NGrams/Unigrams_All_cleaned.RData')
save(Bigrams_all_cleaned, file='NGrams/Bigrams_All_cleaned.RData')
save(Trigrams_all_cleaned, file='NGrams/Trigrams_All_cleaned.RData')

########################
## Ngrams Cleansing 2 ##
########################
rm(list=ls(all=TRUE));gc(reset=TRUE);par(mfrow=c(1,1))
load('NGrams/Trigrams_news_cleaned.RData')

dim(Trigrams_blog_cleaned)
Trigrams_blog_cleaned <- Trigrams_blog_cleaned[-which(Trigrams_blog_cleaned[,2] == 1), ]
save(Trigrams_blog_cleaned, file='NGrams/Trigrams_blog_freq_cleaned.RData')

dim(Trigrams_news_cleaned)
Trigrams_news_cleaned <- Trigrams_news_cleaned[-which(Trigrams_news_cleaned[,2] == 1), ]
save(Trigrams_news_cleaned, file='NGrams/Trigrams_news_freq_cleaned.RData')

dim(Trigrams_twitter_cleaned)
Trigrams_twitter_cleaned <- Trigrams_twitter_cleaned[-which(Trigrams_twitter_cleaned[,2] == 1), ]
save(Trigrams_twitter_cleaned, file='NGrams/Trigrams_twitter_freq_cleaned.RData')

load('NGrams/Bigrams_all_cleaned.RData')
dim(Bigrams_all_cleaned)
Bigrams_all_cleaned <- Bigrams_all_cleaned[-which(Bigrams_all_cleaned[,2] == 1), ]
save(Bigrams_all_cleaned, file='NGrams/Bigrams_all_freq_cleaned.RData')

load('NGrams/Trigrams_all_freq_cleaned.RData.RData')
dim(Unigrams_all)
Bigrams_all_cleaned <- Bigrams_all_cleaned[-which(Bigrams_all_cleaned[,2] == 1), ]
save(Bigrams_all_cleaned, file='NGrams/Bigrams_all_freq_cleaned.RData')

#############
## predict ##
#############
load('NGrams/Trigrams_All_cleaned.RData')
input <- 'are you'
predict <- grep(input, Trigrams_all_cleaned[,1])
Trigrams_all_cleaned[predict[1:5],]