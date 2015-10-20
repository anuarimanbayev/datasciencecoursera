fix <- function(){
        # Loading Data
        file <- "fix.txt"
        #inputData <- read.fwf("fix.txt", widths=c(2,2,2,2,2))
        #inputData <- read.fwf("fix.txt", widths=c(2,2,2))
        inputData <- read.fwf("fix.txt", widths=c(5,5))
        inputData
}