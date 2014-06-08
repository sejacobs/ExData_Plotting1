## This R script assumes you have unzipped the data file (household_power_consumption.txt) into your working directory, in a folder called ex-data003

library(data.table)

##First read in the data
data <- read.table("./exdata-003/household_power_consumption.txt", header = TRUE, sep = ";")

##Adjust the date
data$Date <- as.Date(data$Date, "%d/%m/%Y")

##Create a variable that contains the dates of interest
dates <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")

## Subset to extract the data for only the dates of interest
clean_data <- subset(data, Date %in% dates)

## Combine date and time
dateStr <- paste(clean_data$Date, clean_data$Time)
datetime <- strptime(dateStr, format="%Y-%m-%d %H:%M:%S")

##Convert appropriate data to numeric
clean_data$Global_active_power <- as.numeric(clean_data$Global_active_power)

##Open a file device to create "plot2.png"
png(filename="plot2.png", width=480, height=480)

plot(datetime, 
     clean_data$Global_active_power, 
     type="l", 
     xlab="", 
     ylab="Global Active Power (kilowatts)")

dev.off()
