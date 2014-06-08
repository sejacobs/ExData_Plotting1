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

##Open a file device to create "plot1.png"
png("plot1.png", width=480, height=480)

##Produce the histogram
hist(as.numeric(clean_data$Global_active_power)/1000, 
     col = 'red', 
     xlab = 'Global Active Power (kilowatts)', 
     ylab = 'Frequency',
     main  = "Global Active Power")

##Close the file device
dev.off()

