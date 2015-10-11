corr2 <- function(directory, threshold = 0) {
        ## ==== Homework Assignment 1: Part 3 ====
        ## Creates a list of files with prepended directory
        files_list <- list.files(directory, full.names=TRUE)
        
        ## Instantiation
        specdata <- data.frame()
        cor_output <- c(0)
        void <- c(0)
        
        #cor_output <- cor(yourFile$nitrate, yourFile$sulfate, use = "complete.obs")
        
        #site <- read.csv("specdata/001.csv")
        #df <- site[complete.cases(site), ]
        
        # Using lapply to get the entire dataset
        # specdata <- lapply(files_list, read.csv)
        # tapply(specdata$sulfate, specdata$nitrate, cor)
        
        ## For Loop for finding Correlations between sulfate and nitrate for Ids where Complte Cases > Threshold
        id <- 1:332
        for (i in id) {
                ## Reading CSV files
                specdata <- rbind(specdata, read.csv(files_list[i]))
                ##Using the complete() function from complete.R in my corr.R if you want to get all the complete cases of all monitors.
                completecases <- complete(directory, i)
                
                if (completecases[,2] > threshold) {
                        # Subset sulfate
                        sulfateVector <- specdata[, 2]
                        # Subset nitrate
                        nitrateVector <- specdata[, 3]
                        # Apply cor function
                        cor_output <- cor(sulfateVector, nitrateVector)
                } else {
                        void <- c(0)
                }
        }
        cor_output
}
## 'directory' is a character vector of length 1 indicating
## the location of the CSV files

## 'threshold' is a numeric vector of length 1 indicating the
## number of completely observed observations (on all
## variables) required to compute the correlation between
## nitrate and sulfate; the default is 0

## Return a numeric vector of correlations
## NOTE: Do not round the result!

## Write a function that takes a directory of data files and a threshold for complete cases and 
## calculates the correlation between sulfate and nitrate for monitor locations where the number 
## of completely observed cases (on all variables) is greater than the threshold. The function 
## should return a vector of correlations for the monitors that meet the threshold requirement. 
## If no monitors meet the threshold requirement, then the function should return a numeric vector 
## of length 0.