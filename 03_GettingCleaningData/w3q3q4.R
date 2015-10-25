w3q3q4 <- function(){
        # Loading Data
        library(dplyr)
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
        # High income: OECD
        yesOECD <- filter(eduData, Income.Group=="High income: OECD")
        #str(yesOECD)
        #head(yesOECD,10)
        #tail(yesOECD,10)
        # High income: nonOECD
        nonOECD <- filter(eduData, Income.Group=="High income: nonOECD")
        #str(nonOECD)
        #head(nonOECD,10)
        #tail(nonOECD,10)
        
        yesData <- merge(x=sortedData,y=yesOECD,by.x="CountryCode",by.y="CountryCode")
        #str(yesData)
        #head(yesData,30)
        result1 <- mean(as.integer(yesData$Ranking))
        result1
        # What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?
        # Average GDP ranking for the "High income: OECD" group is 32.96667
        
        noData <- merge(x=sortedData,y=nonOECD,by.x="CountryCode",by.y="CountryCode")
        #str(noData)
        #head(noData,23)
        result2 <- mean(as.integer(noData$Ranking))
        result2
        # What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?
        # Average GDP ranking for the "High income: nonOECD" group is 91.91304
}