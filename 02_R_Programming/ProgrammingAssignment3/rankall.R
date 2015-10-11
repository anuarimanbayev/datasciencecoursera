rankall <- function(outcome, num = "best"){
        ## Suppress warnings
        options(warn=-1)
        
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        # Ordering the Unique State List alphabetically from the very beginning
        ordered_datastate <- data$State[order(data$State)]
        states <- unique(ordered_datastate)
        
        ## We generate an empty vector that we will fill later, row by row, to generate our final output
        output <- vector()
        
        ## MANUAL TESTING
        ## Manual testing on a test case basis is the best
        #statesdata <- data [grep(states[1],data$State),]
        #orderdata <- order(as.numeric(statesdata[, 11]), statesdata[, 2], na.last = NA)
        #resultdata <- statesdata[orderdata,]
        #size <- nrow(resultdata)
        #if (num == "best") {
        #        rank <- 1
        #} else if (num == "worst") {
        #        rank <- nrow(resultdata)
        #} else if (num > nrow(resultdata)) {
        #        rank <- c("NA")
        #} else if (num <= nrow(resultdata)) {
        #        rank <- num
        #} else {
        #        stop("invalid rank")
        #}
        #rank
        #result <- c(resultdata[rank, 2], resultdata[rank, 7])
        #result
        
        # For loop through the unique list of alphabetically ordered state names
        for (i in 1:length(states)) {
                ## statesdata subsets data by the iterated state
                statesdata <- data [grep(states[i],data$State),]
                
                # Outcome Handling
                if (outcome == "heart attack") {
                        ## orderdata orders statesdata by column 11 (which is 'mortality rate for heart attack', and by 'Hospital.Name'.)
                        orderdata <- order(as.numeric(statesdata[, 11]), statesdata[, 2], na.last = NA)
                        resultdata <- statesdata[orderdata,]
                } else if (outcome == "heart failure") {
                        ## orderdata orders statesdata by column 11 (which is 'mortality rate for heart attack', and by 'Hospital.Name'.)
                        orderdata <- order(as.numeric(statesdata[, 17]), statesdata[, 2], na.last = NA)
                        resultdata <- statesdata[orderdata,]
                } else if (outcome == "pneumonia") {
                        ## orderdata orders statesdata by column 11 (which is 'mortality rate for heart attack', and by 'Hospital.Name'.)
                        orderdata <- order(as.numeric(statesdata[, 23]), statesdata[, 2], na.last = NA)
                        resultdata <- statesdata[orderdata,]
                } else {
                        stop("invalid outcome")
                }
                
                # Rank Handling
                if (num == "best") {
                        rank <- 1
                } else if (num == "worst") {
                        rank <- nrow(resultdata)
                } else if (num > nrow(resultdata)) {
                        rank <- c("NA")
                } else if (num <= nrow(resultdata)) {
                        rank <- num
                } else {
                        stop("invalid rank")
                }
                
                output <- append (output, as.character(c(resultdata[rank, 2],states[i])))
        }
        ## It's simpler to generate a matrix rather first and then convert it to a data frame immediately after
        output <- as.data.frame(matrix(output,length(states),2, byrow = TRUE))
        ## Name of the columns will be "hospital" and "state". Name of the rows are the state names.
        colnames(output) <- c("hospital", "state")
        rownames(output) <- states
        return(output)
}