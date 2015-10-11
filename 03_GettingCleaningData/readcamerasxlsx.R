readcamerasxlsx <- function(){
        ## Create Data Folder if it doesn't exist within the working directory
        ## WOrking directory is the DSC_Working_Directory
        if (!file.exists("data")) {
                dir.create("data")
        }
        
        # Download the cameras.csv from the internet
        fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
        ## Apparently the download mode needs to be set properly as write-binary (wb) since xlsx is basically a binary file (zip)
        download.file(fileUrl, destfile = "./data/cameras.xlsx", mode='wb')
        list.files("./data")
        
        # Date the dataset since it may be updated and thus changed
        dateDownloaded <- date()
        dateDownloaded
        
        # Now, actually read in the dataset into memory, not just save under a new "data" folder
        # Use read.table or read.csv (CSV is the most common flat raw data type)
        library(xlsx)
        
        camerasData <- read.xlsx("./data/cameras.xlsx", sheetIndex=1,header=TRUE)
        head(camerasData)
        
        # Reading specific rows and columns
        colIndex <- 2:3
        rowIndex <- 1:4
        camerasDataSubset <- read.xlsx("./data/cameras.xlsx",sheetIndex=1,colIndex=colIndex,rowIndex=rowIndex)
        camerasDataSubset
}