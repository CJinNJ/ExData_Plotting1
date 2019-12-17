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


## Plot the data as a line chart. 3 Columns: Sub_metering_1, 2 & 3...
with (data,plot(Sub_metering_1~DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab=""))
lines(data$Sub_metering_2~data$DateTime, col='Red')
lines(data$Sub_metering_3~data$DateTime, col='Blue')

##   Add the Legend
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Copy plot to PNG File
dev.copy(png, file="plot3.png")
dev.off()
