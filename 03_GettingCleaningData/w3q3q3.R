w3q3q3 <- function(){
        # Loading Data
        library(dplyr)
        #library(plyr)
        gdpData = read.csv("getdata-data-GDP.csv", header=FALSE, na.strings="", skip=5, stringsAsFactors=FALSE)
        # Setting stringsAsFactors to FALSE was crucial in dealing with string character variables versus factor variables
        gdpData <- subset(gdpData, select = c(V1,V2,V4,V5))
        names(gdpData) = c("CountryCode","Ranking","Economy","GDP")
        gdpData <- gdpData[1:190,]
        #str(gdpData)
        #head(gdpData)
        #tail(gdpData)
        
        edcData = read.csv("getdata-data-EDSTATS_Country.csv", header=TRUE, na.strings="", stringsAsFactors=FALSE)
        #str(edcData)
        #head(edcData)
        
        
        # Finding intersection of matching country codes between the two data frames
        intersection <-intersect(gdpData$CountryCode, edcData$CountryCode)
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
        
        #ranking <- as.integer(gdpData$Ranking)
        #str(ranking)
        #newData <- gdpData[order(-ranking),]
        #head(newData)
        #tail(newData)
        
        mergedData <- merge(x=gdpData,y=subsetData,by.x="CountryCode",by.y="CountryCode")
        #str(mergedData)
        #head(mergedData)
        #tail(mergedData)
        
        ranking <- as.integer(mergedData$Ranking)
        sortedData <- mergedData[order(-ranking),]
        #str(sortedData)
        #head(sortedData,13)
        #tail(sortedData)
        result2 <- sortedData[13,]
        result2
}