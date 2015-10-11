plot2 <- function(){
        # Loading Data
        library(data.table)
        powerData = fread("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")
        powerData <- as.data.frame(powerData)
        usedData <- powerData[powerData$Date %in% c("1/2/2007","2/2/2007") ,]
        
        # Displaying Data
        library(datasets)
        # Utilizing the combination of Date/Time instead of ONLY Date or ONLY Time variables
        datetimes <- strptime(paste(usedData$Date, usedData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
        # Setting to numeric
        globalActivePower <- as.numeric(usedData$Global_active_power)
        # Simple plot command with x and y sets, setting as type="l" for line, x label as missing or none, y label as pervious
        plot(datetimes, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
        dev.copy(png, file = "plot2.png", width=480,height=480,units="px") ## Copy plot2 to a PNG file
        dev.off()
}