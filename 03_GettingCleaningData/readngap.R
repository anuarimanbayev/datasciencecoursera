readngap <- function(){
        ## Create Data Folder if it doesn't exist within the working directory
        ## WOrking directory is the DSC_Working_Directory
        if (!file.exists("data")) {
                dir.create("data")
        }
        
        # Download the cameras.csv from the internet
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
        
        ## Apparently the download mode needs to be set properly as write-binary (wb) since xlsx is basically a binary file (zip)
        download.file(fileUrl, destfile = "./data/gov_NGAP.xlsx", mode='wb')
        #list.files("./data")
        
        # Date the dataset since it may be updated and thus changed
        dateDownloaded <- date()
        #dateDownloaded
        
        # Now, actually read in the dataset into memory, not just save under a new "data" folder
        # Use read.table or read.csv (CSV is the most common flat raw data type)
        library(xlsx)
        ngapData <- read.xlsx("./data/gov_NGAP.xlsx", sheetIndex=1,header=TRUE)
        #head(ngapData)
        
        # Quiz Question 3 code
        # Reading specific rows and columns
        colIndex <- 7:15
        rowIndex <- 18:23
        dat <- read.xlsx("./data/gov_NGAP.xlsx",sheetIndex=1,colIndex=colIndex,rowIndex=rowIndex)
        sum(dat$Zip*dat$Ext,na.rm=T)
}