w4q4q1 <- function(){
        ## Create Data Folder if it doesn't exist within the working directory
        ## My working directory is the DSC_Working_Directory
        if (!file.exists("data")) {
                dir.create("data")
        }
        
        # Download the CSV data from the internet
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
        filePath <- file.path(getwd(), "/data/idaho_housing.csv")
        download.file(fileUrl, filePath)
        #list.files("./data")
        
        # Be sure to include the data.table library that contains the fread function.
        library(data.table)
        inputData <- fread(filePath)
        #inputData
        #str(inputData)
        #head(inputData)
        splitNames = strsplit(names(inputData),"wgtp")
        #splitNames
        splitNames[[123]]
}