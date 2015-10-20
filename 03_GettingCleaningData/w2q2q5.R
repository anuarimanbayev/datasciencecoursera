w2q2q5 <- function(){
        # Loading Data
        file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
        # It's all about counting all characters and formattting to ease data manipulation later
        inputData <- read.fwf(file, widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4), skip=4)
        #head(inputData)
        
        result <- sum(inputData$V4)
        result
}