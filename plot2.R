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

## Plot 2
if(!file.exists("plot2.png")) {
  png("plot2.png", width = 480, height = 480)
  with(sub_data,plot(Date_Time, Global_active_power, type="l", xlab = "", ylab="Global Active Power (Kilowatts)"))
  dev.off()
}