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

##Open a file device to create "plot4.png"

png(filename="plot4.png", width=480, height=480)

##Set parameters for graphical display
par(mfrow=c(2, 2))

##Add the first plot
plot(datetime, 
     clean_data$Global_active_power, 
     type="l", 
     xlab="", 
     ylab="Global Active Power (kilowatts)")

##Add the second plot with appropriate labeling
plot(datetime,
     as.numeric(clean_data$Voltage), 
     type="l", 
     ylab="Voltage")

##Add the third plot
##Third plot, conversions
clean_data$Sub_metering_1 <- as.numeric(clean_data$Sub_metering_1)
clean_data$Sub_metering_2 <- as.numeric(clean_data$Sub_metering_2)
clean_data$Sub_metering_3 <- as.numeric(clean_data$Sub_metering_3)

##Create the third plot with Sub_metering_1
plot(datetime,   
     clean_data$Sub_metering_1, 
     type="l", 
     col="black", 
     xlab="", 
     ylab="Energy sub metering")

##Add Sub_metering2 to the third plot
points(datetime, 
       clean_data$Sub_metering_2, 
       type="l", 
       col="red")

##Add Sub_metering3 to the third plot
points(datetime, 
       clean_data$Sub_metering_3, 
       type="l", 
       col="blue")

##Add the legend to the third plot
legend("topright",
       bty = "n",
       col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       box.lwd=0)

##Add the fourth plot

plot(datetime,
     as.numeric(clean_data$Global_reactive_power), 
     type="l", 
     ylab="Global_reactive_power")

##close the file device
dev.off()