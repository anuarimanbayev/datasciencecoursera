complete <- function(directory, id = 1:332) {
        ## ==== Homework Assignment 1: Part 2 ====
        ## Creates a list of files with prepended directory
        files_list <- list.files(directory, full.names=TRUE)
        
        ## Instantiation
        specdata <- data.frame()
        nobsdata <- data.frame()
        
        ## For Loop
        for (i in id) {
                specdata <- rbind(specdata, read.csv(files_list[i]))
                nobs <- sum(complete.cases(specdata))
                new_row <- c(i, nobs)
                nobsdata <- rbind(nobsdata, new_row)
                # Setting Column Names to ID and Nobs instead of 30L for 30 integer and 932L for 932 integer in example 30:25
                colnames(nobsdata) <- c("id", "nobs")
                # Important to reset the specdata for the next row to avoid the cumulative effect
                specdata <- data.frame()
        }
        ## Return just the new data frame, Nobs of complete cases
        nobsdata
}
## 'directory' is a character vector of length 1 indicating
## the location of the CSV files

## 'id' is an integer vector indicating the monitor ID numbers
## to be used

## Return a data frame of the form:
## id nobs
## 1  117
## 2  1041
## ...
## where 'id' is the monitor ID number and 'nobs' is the
## number of complete cases