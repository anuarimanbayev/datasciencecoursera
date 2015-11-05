w4q4q2 <- function(){
        ## Loading Data
        # Load the Gross Domestic Product data for the 190 ranked countries
        library(dplyr)
        library(stringr)
        gdpData = read.csv("getdata-data-GDP.csv", header=FALSE, na.strings="", skip=5, stringsAsFactors=FALSE)
        gdpData <- subset(gdpData, select = c(V1,V2,V4,V5))
        names(gdpData) = c("CountryCode","Ranking","Economy","GDP")
        gdpData <- gdpData[1:190,]
        #str(gdpData)
        #head(gdpData)
        
        
        ## Processing Data
        # Week #4 Quiz #4 Question #2
        # Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?
        result1 <- gsub(",","",gdpData$GDP)
        result2 <- str_trim(result1)
        result3 <- mean(as.integer(result2))
        result3
}