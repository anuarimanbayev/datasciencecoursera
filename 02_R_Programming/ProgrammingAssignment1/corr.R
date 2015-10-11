corr <- function(directory, threshold = 0) {
        ## ==== Homework Assignment 1: Part 3 ====
        ## Creates a list of files with prepended directory
        files_list <- list.files(directory, full.names=TRUE)
        
        ## Instantiation
        cor_output <- numeric(0)
        cor_vector <- numeric(0)
        cor_matrix <- numeric(0)
        void <- numeric(0)
        result <- numeric(0)
        threshold_id <- numeric(0)
        
        # List of IDs and number of completes, obtaine from the `complete` function from Part 2
        completecases <- complete(directory, 1:332)
        thresholdcases <- data.frame()
        fullcases <- data.frame()
        
        # For loop to determine ONLY Thresholdcases and Thresholdlist
        for (i in 1:332) {
                ##Using the complete() function from complete.R in my corr.R if you want to get all the complete cases of all monitors.
                fullcases <- complete(directory, i)
                
                if (fullcases[,2] > threshold) {
                        threshold_id <- rbind(threshold_id, c(i))
                        new_row <- c(i, fullcases[,2])
                        thresholdcases <- rbind(thresholdcases, new_row)
                        colnames(thresholdcases) <- c("id", "nobs")
                } else {
                        result <- void
                }
        }
        #thresholdcases
        #threshold_id
        threshold_id_vector <- as.vector(threshold_id)
        #threshold_id_vector
        
        # STEP 2
        finaldata <- data.frame()
        
        for (i in threshold_id_vector) {
                finaldata <- rbind(finaldata, read.csv(files_list[i]))
                cor_output <- cor(finaldata$nitrate, finaldata$sulfate, use = "complete.obs")
                cor_matrix <- rbind(cor_matrix, c(cor_output))
                finaldata <- data.frame()
        }
        cor_vector <- as.vector(cor_matrix)
        ##round(cor_vector,digits=5)
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