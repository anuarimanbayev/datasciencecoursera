w3q3q5 <- function(){
        # Loading Data
        library(dplyr)
        # Hmisc for 5 quantile cutting2
        library(Hmisc)
        gdpData = read.csv("getdata-data-GDP.csv", header=FALSE, na.strings="", skip=5, stringsAsFactors=FALSE)
        # Setting stringsAsFactors to FALSE was crucial in dealing with string character variables versus factor variables
        gdpData <- subset(gdpData, select = c(V1,V2,V4,V5))
        names(gdpData) = c("CountryCode","Ranking","Economy","GDP")
        gdpData <- gdpData[1:190,]
        #str(gdpData)
        #head(gdpData)
        #tail(gdpData)
        
        edcData = read.csv("getdata-data-EDSTATS_Country.csv", header=TRUE, na.strings="", stringsAsFactors=FALSE)
        eduData <- tbl_df(edcData)
        #str(eduData)
        #head(eduData)
        #tail(eduData)
        
        
        # Finding intersection of matching country codes between the two data frames
        intersection <-intersect(gdpData$CountryCode, eduData$CountryCode)
        result1 <- length(intersection)
        result1
        #str(intersection)
        #head(intersection)
        #tail(intersection, 13)
        # Creating a new data frame of just the matching intersected country codes to merge later
        subsetData <- data.frame(as.vector(intersection),stringsAsFactors=FALSE)
        names(subsetData) = c("CountryCode")
        #str(subsetData)
        #head(subsetData)
        #tail(subsetData)
        
        mergedData <- merge(x=gdpData,y=subsetData,by.x="CountryCode",by.y="CountryCode")
        #str(mergedData)
        #head(mergedData)
        #tail(mergedData)
        
        ranking <- as.integer(mergedData$Ranking)
        sortedData <- mergedData[order(-ranking),]
        sortedData <- tbl_df(sortedData)
        #str(sortedData)
        #head(sortedData,13)
        #tail(sortedData)
        
        eduData <- select(eduData, CountryCode, Income.Group)
        #str(eduData)
        #head(eduData,10)
        #tail(eduData,10)
        
        finData <- merge(x=sortedData,y=eduData,by.x="CountryCode",by.y="CountryCode")
        ranking <- as.integer(finData$Ranking)
        #str(finData$Ranking)
        finData <- finData[order(ranking),]
        #str(finData)
        #head(finData,10)
        #tail(finData,10)
        
        # Cut the GDP ranking into 5 separate quantile groups. 
        # Make a table versus Income.Group. 
        # How many countries are Lower middle income but among the 38 nations with highest GDP?
        finData$RankGroups = cut2(as.integer(finData$Ranking),g=5)
        #finData$RankGroups
        #str(finData$RankGroups)
        #table(finData$RankGroups)
        result <- table(finData$RankGroups, finData$Income.Group)
        result
}