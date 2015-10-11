readexamplehtml <- function(){
        ## Create Data Folder if it doesn't exist within the working directory
        ## WOrking directory is the DSC_Working_Directory
        if (!file.exists("data")) {
                dir.create("data")
        }
        
        # Download the simple.xml from the internet
        fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
        
        # Set document to the result of the parse function
        doc <- htmlTreeParse(fileUrl,useInternal=TRUE)
        
        # Set records variable
        records <- xpathSApply(doc,"//li[@class='record']",xmlValue)
        
        # Set teams variable
        teams <- xpathSApply(doc,"//li[@class='team-name']",xmlValue)
        teams
        records
}