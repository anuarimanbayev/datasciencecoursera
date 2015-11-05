w4q4q3 <- function(){
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
        # Week #4 Quiz #4 Question #3
        # In the data set from Question 2 what is a regular expression that would allow you to count the number of countries whose name begins with "United"? 
        # Assume that the variable with the country names in it is named countryNames. How many countries begin with United?
        countryNames <- gdpData$Economy
        #countryNames
        result <- grep("^United",countryNames)
        result
        # Result Output: [1] 1 6 32
        # Thus 3 countries begin with United
}