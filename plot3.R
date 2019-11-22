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

#====================================== Energy Sub-Metering over Time ========================================
sub_data <- subset(power, Date=="2007-2-1" | Date=="2007-2-2")

# Create Datatime column which combine of Date and Time columns

energy <- data.frame(dnt = as.POSIXct(paste(sub_data$Date, sub_data$Time)),
                sub1= as.numeric(sub_data$Sub_metering_1),
                sub2= as.numeric(sub_data$Sub_metering_2),
                sub3= as.numeric(sub_data$Sub_metering_3))

png("plot3.png")
plot(energy$dnt, energy$sub1, type="n", xlab="", ylab="Energy sub metering")


lines(energy$dnt, energy$sub1, col="black")
lines(energy$dnt, energy$sub2, col="red")
lines(energy$dnt, energy$sub3, col="blue")

legend("topright", 
       pch=c(NA,NA,NA), 
       col=c("black", "red", "blue"), 
       legend=c("Sub 1","Sub 2","Sub 3"),
       lwd=1,
       cex=1.0
)
dev.off()
