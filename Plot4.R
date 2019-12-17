## Download and unzip file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="data.zip", method="curl")
unzip ("data.zip", unzip = "internal")

## Read data
data_full <- read.table("household_power_consumption.txt", header=TRUE, na.strings="?", sep=";")

## Extract only the dates we need
data <- data_full[(data_full$Date=="1/2/2007" | data_full$Date=="2/2/2007" ), ]

## Format date to DD/MM/YY
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

## Combine date & time together to create a new value called date time
dateTime <- paste(data$Date, data$Time)

## Add new column to data called datetime
data$DateTime <- as.POSIXct(dateTime)

#plot4

## Setup to contain 4 charts and modify the margins to fit.  Add 2 lines to top of outer margin
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

## All charts will is the same data table so this cuts down on typing
with(data, {
        
## Plot the 1st chart (same as plot 2)        
        plot(Global_active_power~DateTime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")

## Plot 2nd chart        
        plot(Voltage~DateTime, type="l", 
             ylab="Voltage (volt)", xlab="datetime")
        
## Plot 3rd chart (same as plot 3)        
        plot(Sub_metering_1~DateTime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~DateTime,col='Red')
        lines(Sub_metering_3~DateTime,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        
## Plot 4th chart
        plot(Global_reactive_power~DateTime, type="l", 
             ylab="Global Rective Power (kilowatts)",xlab="datetime")
})

## Copy plot to PNG File
dev.copy(png, file="plot4.png")
dev.off()