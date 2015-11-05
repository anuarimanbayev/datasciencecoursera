w4q4q4 <- function(){
        ## Loading Data
        # Load the Gross Domestic Product data for the 190 ranked countries
        library(dplyr)
        gdpData = read.csv("getdata-data-GDP.csv", header=FALSE, na.strings="", skip=5, stringsAsFactors=FALSE)
        # Setting stringsAsFactors to FALSE was crucial in dealing with string character variables versus factor variables
        gdpData <- subset(gdpData, select = c(V1,V2,V4,V5))
        names(gdpData) = c("CountryCode","Ranking","Economy","GDP")
        gdpData <- gdpData[1:190,]
        #str(gdpData)
        #head(gdpData)
        #tail(gdpData)
        
        # Load the educational data
        edcData = read.csv("getdata-data-EDSTATS_Country.csv", header=TRUE, na.strings="", stringsAsFactors=FALSE)
        eduData <- tbl_df(edcData)
        #str(eduData)
        #head(eduData)
        #tail(eduData)
        
        # Finding intersection of matching country codes between the two data frames
        intersection <-intersect(gdpData$CountryCode, eduData$CountryCode)
        #result1 <- length(intersection)
        #result1
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
        
        
        ## Processing Data
        # Week #4 Quiz #4 Question #4
        # Of the countries for which the end of the fiscal year is available, how many end in June?
        eduData <- select(eduData, CountryCode, Special.Notes)
        #str(eduData)
        resultData <- merge(x=sortedData,y=eduData,by.x="CountryCode",by.y="CountryCode")
        #str(resultData)
        
        juneFiscal <- grep("^Fiscal year end: June",resultData$Special.Notes)
        result <- length(juneFiscal)
        result
        # 16 countries end the fiscal year in June
}