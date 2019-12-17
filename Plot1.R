#download and unzip file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="data.zip", method="curl")
unzip ("data.zip", unzip="internal")

##read data setting na values as ?
data_full <- read.table("household_power_consumption.txt", header=TRUE, na.strings="?", sep=";")

##  Extract the data for just the dates needed
data <- data_full[(data_full$Date=="1/2/2007" | data_full$Date=="2/2/2007" ), ]

## Plot 1 histogram for Global_Active Power and add labels
hist(data$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## export file to dng
dev.copy(png, file="plot1.png")
dev.off()