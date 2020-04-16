# 1. Loading the data
if(!file.exists("household_power_consumption.txt")) {
  tmp<-tempfile()
  fileUrl<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl,tmp)
  unzip(tmp)
  unlink(tmp)
}


## Reading data
dataset<-read.table("household_power_consumption.txt", sep=";", header = TRUE, stringsAsFactors = FALSE, na.strings = "?")
sub_data<-subset(dataset, Date %in% c("1/2/2007","2/2/2007"))

## Converting Date and Time
sub_data$Date_Time<-strptime(paste(sub_data$Date,sub_data$Time),format="%d/%m/%Y %H:%M:%S")

# 2. Making Plots

## Plot 4
if(!file.exists("plot4.png")) {
  png("plot4.png", width = 480, height = 480)
  par(mfrow=c(2,2))
  with(sub_data, {
    plot(Date_Time, Global_active_power, type="l", xlab = "", ylab="Global Active Power")
    
    plot(Date_Time, Voltage, type="l", xlab = "datetime", ylab="Voltage")
    
    plot(Date_Time,Sub_metering_1, type="n", xlab="", ylab = "Energy sub metering")
    lines(Date_Time,Sub_metering_1)
    lines(Date_Time,Sub_metering_2, col="red")
    lines(Date_Time,Sub_metering_3, col="blue")
    legend("topright", lty=1,  col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
    
    plot(Date_Time, Global_reactive_power, type="l", xlab = "datetime", ylab ="Global_reactive_power")
    
  })
  dev.off()
}