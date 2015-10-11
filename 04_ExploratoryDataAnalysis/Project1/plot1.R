plot1 <- function(){
        #powerData = read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")
        
        # Testing fread
        library(data.table)
        powerData = fread("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")
        powerData <- as.data.frame(powerData)
        
        # Getting a sense for the entire dataset
        #str(powerData)
        
        # Testing recognition of header column names such as Date and Time
        #powerData$Date
        #powerData$Time
        
        # Converting these Date and Time factors into more appropriate Date and Time classes
        #dates <- as.Date(powerData$Date)
        #dates
        #str(dates)
        powerData$Date <- as.Date(powerData$Date, "%d/%m/%Y")
        #str(powerData)
        
        usedData <- subset(powerData, powerData$Date >= "2007-02-01" & powerData$Date <= "2007-02-02")
        #str(usedData)
        
        library(datasets)
        hist(usedData$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red") ## Draw a new plot
        dev.copy(png, file = "plot1.png", width=480,height=480,units="px") ## Copy my plot to a PNG file
        dev.off() ## Don't forget to close the PNG device!
}