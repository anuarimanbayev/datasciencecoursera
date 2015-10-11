rankhospital <- function(state, outcome, num = "best") {
        ## Suppress warnings
        options(warn=-1)
        
        ## Read outcome data
        ## 30-day death rate
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        states <- data[,7]
        
        ## Check that state and outcome are valid
        # Testing that state input of 2-character long vector is valid or not
        if (is.element(state, states)) {                # if the element state is found within the states character vector column of 7 within the data
                validstate <- state                     # return validstate
        } else if (nchar(state) < 2) {                  # if the character vector is less than 2 characters long, like "TX"
                stop("invalid state")                   # using stop function to throw an error message
        } else if (nchar(state) > 2) {                  # if the character vector is more than 2 characters long, like "TEXAS"
                stop("invalid state")                   # using stop function to throw an error message
        } else {                                        # if its 2-character vector not found in the 7th column of the data, states, such as "BB". There is no such state as with initials "BB"
                stop("invalid state")                   # using stop function to throw an error message
        }
        
        # Testing that outcome is exactly inputted, only accpeting lower-case inputs of 'heart attack', 'heart failure', and 'pneumonia'
        if (outcome == "heart attack") {
                validoutcome <- outcome                 # return validoutcome
        } else if (outcome == "heart failure") {
                validoutcome <- outcome                 # return validoutcome
        } else if (outcome == "pneumonia") {
                validoutcome <- outcome                 # return validoutcome
        } else {
                stop("invalid outcome")                 # otherwise for anything else, upper-case 'HEART attack' or incorrect spellings 'hert attack' or anything else, throw an error message
        }
        
        state_data <- data[data$State == validstate,]
        numHospitals <- length(state_data)
        
        # Testing that num is well inputted
        if (num < numHospitals) {
                rank <- as.numeric(num)
        } else if (num == "best") {
                rank <- as.numeric(1)
        } else if (num == "worst") {
                rank <- as.numeric(numHospitals)
        } else if (num > numHospitals) {
                rank <- c("NA")       
        } else {
                stop("invalid rank")
        }
        
        
        ## Return hospital name in that state with the given rank
        if (validoutcome=="heart attack") {
                variables_data <- state_data[,c(2,7,11)]
                order_data <- order(as.numeric(state_data[, 11]), state_data[, 2], na.last = NA)
        } else if (validoutcome=="heart failure") {
                variables_data <- state_data[,c(2,7,17)]
                order_data <- order(as.numeric(state_data[, 17]), state_data[, 2], na.last = NA)
        } else if (validoutcome=="pneumonia") {
                variables_data <- state_data[,c(2,7,23)]
                order_data <- order(as.numeric(state_data[, 23]), state_data[, 2], na.last = NA)
        }
        
        result_data <- variables_data[order_data, ]
        numRankings <- length(result_data[,3])
        lastrank <- as.numeric(numRankings)
        
        if (num == "worst") {
                result <- result_data[lastrank, 1]
        } else {
                result <- result_data[rank, 1]
        }
        
        result
}