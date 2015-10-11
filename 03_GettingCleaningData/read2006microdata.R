read2006microdata <- function(){
        ## Create Data Folder if it doesn't exist within the working directory
        ## WOrking directory is the DSC_Working_Directory
        if (!file.exists("data")) {
                dir.create("data")
        }
        
        # Download the cameras.csv from the internet
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
        download.file(fileUrl, destfile = "./data/2006microdata.csv")
        #list.files("./data")
        
        # Date the dataset since it may be updated and thus changed
        dateDownloaded <- date()
        #dateDownloaded
        
        # Now, actually read in the dataset into memory, not just save under a new "data" folder
        # Use read.table or read.csv (CSV is the most common flat raw data type)
        microData <- read.csv("./data/2006microdata.csv")
        
        library(dplyr)
        #head(microData)
        
        #QUiz QUestion 1 code
        #filter(microData, VAL == 24)
        # answer is 53 according to my code run
        
        # Quiz Question 2 code
        head(microData)
}