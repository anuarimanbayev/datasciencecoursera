pollutantmean <- function(directory, pollutant, id = 1:332) {
        ## ==== Homework Assignment 1: Part 1 ====
        ## Creates a list of files with prepended directory
        files_list <- list.files(directory, full.names=TRUE)
        
        ## Instantiation
        specdata <- data.frame()
        
        ## Loops through the CSV files, rbinding them together
        for (i in id) {
                specdata <- rbind(specdata, read.csv(files_list[i]))
        }
                
        # Calculates the mean and strips away the NA values
        mean(specdata[, pollutant], na.rm=TRUE)
}
## 'directory' is a character vector of length 1 indicating
## the location of the CSV files

## 'pollutant' is a character vector of length 1 indicating
## the name of the pollutant for which we will calculate the
## mean; either "sulfate" or "nitrate".

## 'id' is an integer vector indicating the monitor ID numbers
## to be used

## Return the mean of the pollutant across all monitors list
## in the 'id' vector (ignoring NA values)
## NOTE: Do not round the result!

## AI Commentary:
## Place the pollutantmean.R file on the same LEVEL of directory as the specdata directory folder
## DO NOT place the pollutantmean.R file INTO the specdata directory folder. 
## This is why I was getting just a numeric vector 1:10 over and over, since the funciton was looking for a specdata folder IN ITS ENVIRONMENT DIRECTORY LEVEL, whie being UNDER or PART of the specdata directory folder
## Much credit and kudos to: https://github.com/rdpeng/practice_assignment/blob/master/practice_assignment.rmd
## Without the above, I was stuck on the the file input handling, but I knew how to read.scv with rbind and looping, I just didn't know how to GET there in the first place.
## Also, after any change/update/save of this pollutantmean.R, in the CONSOLE, the source command had to be rerun to run the function again correctly. Otherwise, R Studio remembers the old function