rm(list=ls())
#======================================Download dataser ========================================
file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Create data folder 
if (!file.exists('data')){
  dir.create('data')
}

# Download the file if not exist
download.file(file_url, "data/household_power_consumption.zip")
unzip('data/household_power_consumption.zip',exdir = 'data/')

power <- read.csv("data/household_power_consumption.txt", stringsAsFactors = FALSE, sep = ";", header = TRUE)
power$Date <- as.Date(power$Date, format = "%d/%m/%Y") 

#====================================== Consumption over time ========================================
sub_data <- subset(power, Date=="2007-2-1" | Date=="2007-2-2")

# Create Datatime column which combine of Date and Time columns
Date_Time <- paste(sub_data$Date, sub_data$Time)
sub_data$DateTime <- as.POSIXct(Date_Time)

png("plot2.png")
plot(sub_data$Global_active_power ~ sub_data$DateTime, ylab = "Global Active Power (kilowatts)", xlab = "", type = "l")
dev.off()
