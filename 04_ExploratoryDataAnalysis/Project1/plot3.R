plot3 <- function(){
        # Loading Data
        library(data.table)
        powerData = fread("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")
        powerData <- as.data.frame(powerData)
        usedData <- powerData[powerData$Date %in% c("1/2/2007","2/2/2007") ,]
        
        # Displaying Data
        library(datasets)
        # Utilizing the combination of Date/Time instead of ONLY Date or ONLY Time variables
        datetimes <- strptime(paste(usedData$Date, usedData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
        # Setting to numerics
        subMeteringOne <- as.numeric(usedData$Sub_metering_1)
        subMeteringTwo <- as.numeric(usedData$Sub_metering_2)
        subMeteringThree <- as.numeric(usedData$Sub_metering_3)
        # Simple plot command with first sub metering line and then couple more lines added for sub meterings 2 and 3, respectively
        plot(datetimes, subMeteringOne, type="l", xlab="", ylab="Energy sub metering")
        lines(datetimes, subMeteringTwo, type="l", col="red")
        lines(datetimes, subMeteringThree, type="l", col="blue")
        legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=3, col=c("black", "red", "blue"))
        dev.copy(png, file = "plot3.png", width=480,height=480,units="px") ## Copy plot2 to a PNG file
        dev.off()
}