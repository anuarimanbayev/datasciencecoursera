readbaltimorerestaurants <- function(){
        ## Create Data Folder if it doesn't exist within the working directory
        ## WOrking directory is the DSC_Working_Directory
        if (!file.exists("data")) {
                dir.create("data")
        }
        
        # Call in the XML library
        library(XML)
        library(RCurl)
        
        # Download the baltimore restaurants XML from the internet
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
        procUrl <- getURL(fileUrl, ssl.verifypeer = FALSE)
        
        # Set document to the result of the parse function
        doc <- xmlTreeParse(procUrl,useInternal=TRUE)
        
        # Set root node
        rootNode <- xmlRoot(doc)
        # Getting a feel for the data
        #rootNode[[1]]
        #rootNode[[1]][[1]]
        
        # Quiz 1 Quesiton 4
        zipcodes <- xpathSApply(rootNode,"//zipcode",xmlValue)
        table(zipcodes == 21231)
        #nodes = getNodeSet(rootNode,"//zipcode[@zipcode='21231']")
        #nodes
        
        # Get the first name of the root node
        #xmlName(rootNode)
        # Get multiple names of the root node
        #names(rootNode)
        # Directly access parts of the XML document
        #rootNode[[1]]
        # First subset of a subset
        #rootNode[[1]][[1]]
        
        # Programatically extrac parts of the file
        #xmlSApply(rootNode,xmlValue)
        
        # Using XPath 1
        #xpathSApply(rootNode,"//name",xmlValue)
        # Using Xpath 2
        #xpathSApply(rootNode,"//price",xmlValue)
}