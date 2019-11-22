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

#====================================== Various plots ========================================
sub_data <- subset(power, Date=="2007-2-1" | Date=="2007-2-2")

various_data <- data.frame(
    dnt = as.POSIXct(paste(sub_data$Date, sub_data$Time)),
    power=as.numeric(sub_data$Global_active_power),
    sub1= as.numeric(sub_data$Sub_metering_1),
    sub2= as.numeric(sub_data$Sub_metering_2),
    sub3= as.numeric(sub_data$Sub_metering_3),
    volt=as.numeric(sub_data$Voltage),
    powerre=as.numeric(sub_data$Global_reactive_power)
)

par(mfrow=c(2,2),bg="NA")
png("plot4.png")

# Plot 1: top left
with(various_data,{
  plot(various_data$dnt, various_data$power,type="n",xlab="",ylab="Global Active Power (killowatts)")
  lines(various_data$dnt, various_data$power)
})

# Plot 2: top right
with(various_data,{
  plot(various_data$dnt, various_data$volt, type="n",xlab="datetime",ylab="Voltage")
  lines(various_data$dnt, various_data$volt)
})

# Plot 3: bottom left
with(various_data,{
  plot(various_data$dnt, various_data$sub1, type="n",xlab="",ylab="Energy sub metering")
  legend("topright", 
         pch=c(NA,NA,NA), 
         col=c("black", "red", "blue"), 
         legend=c("Sub 1","Sub 2","Sub 3"),
         lwd=1, lty=c(1,1,1),
         bty="n")
  lines(various_data$dnt, various_data$sub1, col="black")
  lines(various_data$dnt, various_data$sub2, col="red")
  lines(various_data$dnt, various_data$sub3, col="blue")
})

# Plot 4: bottom right
with(various_data,{
  plot(various_data$dnt, various_data$powerre,type="n",xlab="datetime",ylab="Global_reactive_power")
  lines(various_data$dnt, various_data$powerre)
})
dev.off()

