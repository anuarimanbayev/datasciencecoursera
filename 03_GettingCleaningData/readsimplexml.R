readsimplexml <- function(){
        ## Create Data Folder if it doesn't exist within the working directory
        ## WOrking directory is the DSC_Working_Directory
        if (!file.exists("data")) {
                dir.create("data")
        }
        
        # Call in the XML library
        library(XML)
        
        # Download the simple.xml from the internet
        fileUrl <- "http://www.w3schools.com/xml/simple.xml"
        
        # Set document to the result of the parse function
        doc <- xmlTreeParse(fileUrl,useInternal=TRUE)
        
        # Set root node
        rootNode <- xmlRoot(doc)
        
        # Get the first name of the root node
        xmlName(rootNode)
        # Get multiple names of the root node
        names(rootNode)
        # Directly access parts of the XML document
        rootNode[[1]]
        # First subset of a subset
        rootNode[[1]][[1]]
        
        # Programatically extrac parts of the file
        xmlSApply(rootNode,xmlValue)
        
        # Using XPath 1
        xpathSApply(rootNode,"//name",xmlValue)
        # Using Xpath 2
        xpathSApply(rootNode,"//price",xmlValue)
}