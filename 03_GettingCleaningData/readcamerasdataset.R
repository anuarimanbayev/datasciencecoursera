readcamerasdataset <- function(){
        ## Create Data Folder if it doesn't exist within the working directory
        ## WOrking directory is the DSC_Working_Directory
        if (!file.exists("data")) {
                dir.create("data")
        }
        
        # Download the cameras.csv from the internet
        fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
        download.file(fileUrl, destfile = "./data/cameras.csv")
        list.files("./data")
        
        # Date the dataset since it may be updated and thus changed
        dateDownloaded <- date()
        dateDownloaded
        
        # Now, actually read in the dataset into memory, not just save under a new "data" folder
        # Use read.table or read.csv (CSV is the most common flat raw data type)
        camerasData <- read.csv("./data/cameras.csv")
        head(camerasData)
}