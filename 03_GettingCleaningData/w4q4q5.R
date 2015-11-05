w4q4q5 <- function(){
        ## Week #4 Quiz #4 Quesiton #5
        # You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices 
        # for publicly traded companies on the NASDAQ and NYSE. Use the following code to download data on 
        # Amazon's stock price and get the times the data was sampled.
        library(quantmod)
        amzn = getSymbols("AMZN",auto.assign=FALSE)
        sampleTimes = index(amzn)
        # Format function was crucial to get to the weekdays
        sampleTimes <- format(sampleTimes, "%Y %a")
        
        ## QUESTIONS: How many values were collected in 2012? How many values were collected on Mondays in 2012?
        #str(sampleTimes)
        #head(sampleTimes)
        # grep function for JUST year 2012
        values2012 <- grep("2012", sampleTimes)
        #str(values2012)
        result1 <- length(values2012)
        #result1
        # 250 values were collected in 2012
        
        #all2012 <- grep("2012", sampleTimes)
        
        #weekdays2012 <- weekdays(all2012)
        #weekdays2012
        
        # grep function for BOTH year 2012 and weekday Monday
        mondays2012 <- grep("2012 Mon", sampleTimes)
        #mondays2012
        result2 <- length(mondays2012)
        result2
        # 47 values were collected on Mondays in 2012
}