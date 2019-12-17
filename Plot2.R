##download and unzip file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="data.zip", method="curl")
unzip ("data.zip", unzip = "internal")

##read data
data_full <- read.table("household_power_consumption.txt", header=TRUE, na.strings="?", sep=";")

## Extract only the dates we need
data <- data_full[(data_full$Date=="1/2/2007" | data_full$Date=="2/2/2007" ), ]

#format date to DD/MM/YY
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Combine date & time together to create a new value called date time
dateTime <- paste(data$Date, data$Time)

## Add new column to data called datetime
data$DateTime <- as.POSIXct(dateTime)

#plot the Global Active Power against DateTime.  Plot Type 1 is a line chart and add correct lables.
plot(data$Global_active_power~data$DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

## Copy plot to PNG File
dev.copy(png, file="plot2.png")
dev.off()
