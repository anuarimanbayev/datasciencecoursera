pollutantmean_lapply <- function(directory, pollutant, id = 1:332) {
	## lapply method!
  
  ## ==== Homework Assignment 1: Part 1 ====
  ## Creates a list of files with prepended directory
  files <- list.files(directory, full.names=TRUE)
  
  ## create an empty list that's the length of our expected output with the input object of the files list
  ## summary(files)
  tmp <- vector(mode = "list", length = length(files))
  ## summary(tmp)
  
  ## Using the expressive lapply function, read in those csv files and drop them into tmp
  str(lapply(files, read.csv))
  
  ## combine tmp into a single data frame
  output <- do.call(rbind, tmp)
  str(output)
  
  # Calculates the mean and strips away the NA values
  ## mean(monitordata[, pollutant], na.rm=TRUE)
}