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

## Plot 1
if(!file.exists("plot1.png")) {
  png("plot1.png", width = 480, height = 480)
  with(sub_data,hist(Global_active_power, main = "Global Active Power", xlab = "Global Active Power (Kilowatts)", ylab ="Frequency", col = "red"))
  dev.off()
  }