#setwd("C:/Users/Anuar Imanbayev/Desktop/DataScienceCourse/DSC_Working_Directory/DDP_Project")

# Load necessary libraries and dependencies
require(data.table)
library(dplyr)
library(DT)
#library(devtools)
#library(Rcpp)
#install_github('ramnathv/rCharts')
library(rCharts)

# Read data
data <- fread("./data/SkillCraft1_Dataset.csv")

# EXPLORATORY DATA ANALYSIS
head(data)
# Recode all ? as NA
data[data=="?"] <- NA
sum(is.na(data)) # 168
length(data$GameId) # 3395
# 3,395 unique SCII replays, with NA rows
mydata <- na.omit(data)
# Removing all rows with NA values
length(mydata$GameID) #3338
# 3.338 unique SCII replays without any NA values


# Hypothesized major predictors of SCII performance:
# League, Age, APM
# optional: HoursPerWeek, TotalHours, TotalMapExplored, WorkersMade, UniqueUnitsMade

# League
#table(mydata$LeagueIndex) # 1-7
#length(table(mydata$LeagueIndex)) # 7
# 7 separate Leagues: Bronze, Silver, Gold, Platinum, Diamond, Master, GrandMaster
# League 8, Professional, had missing ? values recoded as NAs for Age, APM, etc.
leagueNums <- sort(unique(mydata$LeagueIndex))
#table(leagueNums)
# Keeping leagues in order
leagues <- sort(unique(mydata$LeagueIndex))
leagues[leagues=="1"] <- "Bronze"
leagues[leagues=="2"] <- "Silver"
leagues[leagues=="3"] <- "Gold"
leagues[leagues=="4"] <- "Platinum"
leagues[leagues=="5"] <- "Diamond"
leagues[leagues=="6"] <- "Master"
leagues[leagues=="7"] <- "GrandMaster"
# Recoding the dataset itself from Ordinal numbers for leagues to Characters
mydata$LeagueIndex[mydata$LeagueIndex=="1"] <- "Bronze"
mydata$LeagueIndex[mydata$LeagueIndex=="2"] <- "Silver"
mydata$LeagueIndex[mydata$LeagueIndex=="3"] <- "Gold"
mydata$LeagueIndex[mydata$LeagueIndex=="4"] <- "Platinum"
mydata$LeagueIndex[mydata$LeagueIndex=="5"] <- "Diamond"
mydata$LeagueIndex[mydata$LeagueIndex=="6"] <- "Master"
mydata$LeagueIndex[mydata$LeagueIndex=="7"] <- "GrandMaster"

# Age
#table(mydata$Age) # 16-44
# range of ages for eSports professionas between 16 to 44 years old
#length(table(mydata$Age)) # 28
# 28 eSport professional age groups
ages <- sort(unique(mydata$Age))
ages <- as.integer(ages)
#table(ages)

# APM (Actions per Minute)
#table(data$APM)
#length(mydata$APM) # 3338
apms <- sort(unique(mydata$APM))
#table(apms)


## R Package Functions

#' Aggregate dataset by year, piece and theme
#'
#' @param dt data.table
#' @param minAge
#' @param maxAge
#' @param minAPM
#' @param maxAPM
#' @param leagues
#' @return result data.table
#'
groupByAgeAll <- function(dt, minAge, maxAge, minAPM,
                           maxAPM, leagues) {
        result <- dt %>% filter(Age >= minAge, Age <= maxAge,
                                APM >= minAPM, APM <= maxAPM,
                                LeagueIndex %in% leagues)
        return(result)
}

#' Aggregate dataset by leagues
#'
#' @param dt data.table
#' @param minAge
#' @param maxAge
#' @param minAPM
#' @param maxAPM
#' @param leagues
#' @return result data.table
#'
groupByLeague <- function(dt, minAge, maxAge,
                         minAPM, maxAPM, leagues) {
        # use pipelining
        dt <- groupByAgeAll(dt, minAge, maxAge, minAPM,
                            maxAPM, leagues)
        result <- datatable(dt, options = list(iDisplayLength = 20))
        return(result)
}

#' Average APM for each Age Group
#' 
#' @param dt data.table
#' @param minAge
#' @param maxAge
#' @param minAPM
#' @param maxAPM
#' @param leagues
#' @return data.table 2 columns
#'
groupByAPMAgeAvg <- function(dt,  minAge, maxAge, minAPM,
                            maxAPM, leagues) {
        dt <- groupByAgeAll(dt, minAge, maxAge, minAPM,
                             maxAPM, leagues)
        result <- dt %>% 
                group_by(Age) %>% 
                summarise(avgAPM = mean(APM)) %>%
                arrange(Age)
        return(result)      
}

#' Average APM for each League
#'
#' @param dt data.table
#' @param minAge
#' @param maxAge
#' @param minAPM
#' @param maxAPM
#' @param leagues
#' @return data.table 2 columns
#'
#'
groupByAPMLeagueAvg <- function(dt,  minAge, maxAge, minAPM,
                                 maxAPM, leagues) {
        dt <- groupByAgeAll(dt, minAge, maxAge, minAPM,
                             maxAPM, leagues)
        result <- dt %>%
                group_by(LeagueIndex) %>%
                summarise(avgAPM = mean(APM)) %>%
                arrange(LeagueIndex)
        return(result)
}

<<<<<<< HEAD
#' Plot average APM for each Age Group
=======
#' Plot average APM by Age group
>>>>>>> origin/master
#' 
#' @param dt data.table
#' @param dom
#' @param xAxisLabel Age
#' @param yAxisLabel APM
#' @return themesByYear plot
plotAPMByAgeAvg <- function(dt, dom = "apmByAgeAvg", 
                                xAxisLabel = "Age",
                                yAxisLabel = "APM") {
        
        ampByAgeAvg <- nPlot(
                avgAPM ~ Age,
                data = dt,
                type = "lineChart",
                dom = dom, width = 700
        )
        ampByAgeAvg$chart(margin = list(left = 100))
        ampByAgeAvg$chart(color = c('blue', 'green', 'red'))
        ampByAgeAvg$yAxis(axisLabel = yAxisLabel, width = 70)
        ampByAgeAvg$xAxis(axisLabel = xAxisLabel, width = 70)
        ampByAgeAvg
}

#' Plot average APM by League
#'
#' @param dt data.table
#' @param dom
#' @param xAxisLabel league
#' @param yAxisLabel APM
#' @return apmByLeagueAvg plot
plotAPMByLeagueAvg <- function(dt, dom = "apmByLeagueAvg",
                                 xAxisLabel = "Leagues",
                                 yAxisLabel = "APM") {
        apmByLeagueAvg <- nPlot(
                avgAPM ~ LeagueIndex,
                data = dt,
                type = "multiBarChart",
                dom = dom, width = 700
        )
        apmByLeagueAvg$chart(margin = list(left = 100))
        apmByLeagueAvg$chart(color = c('green', 'blue', 'red'))
        apmByLeagueAvg$yAxis(axisLabel = yAxisLabel, width = 100)
        apmByLeagueAvg$xAxis(axisLabel = xAxisLabel, width = 200,
                               rotateLabels = -20, height = 200)
        apmByLeagueAvg
}
