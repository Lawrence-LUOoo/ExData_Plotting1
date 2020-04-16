# 1. Loading the data
if(!file.exists("household_power_consumption.txt")) {
  tmp<-tempfile()
  fileUrl<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl,tmp)
  unzip(tmp)
  unlink(tmp)
}

## Roughly estimate of the dataset in size
top.size<-object.size(read.table("household_power_consumption.txt", sep=";", header = TRUE,nrows = 1000))
lines<- as.numeric(gsub("[^0-9]", "",system("wc -l household_power_consumption.txt", intern=TRUE)))
size.estimate <- lines/1000 * top.size
print(size.estimate, units = "Mb")

## Reading data
dataset<-read.table("household_power_consumption.txt", sep=";", header = TRUE, stringsAsFactors = FALSE, na.strings = "?")
sub_data<-subset(dataset, Date %in% c("1/2/2007","2/2/2007"))

## Converting Date and Time
sub_data$Date_Time<-strptime(paste(sub_data$Date,sub_data$Time),format="%d/%m/%Y %H:%M:%S")

## Reassigning sub_data
sub_data<-subset(sub_data, select = -c(Date,Time))


# 2. Making Plots

## Plot 1
hist(sub_data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (Kilowatts)", ylab ="Frequency", col = "red")

## Plot 2
plot(sub_data$Date_Time, sub_data$Global_active_power, type="l", xlab = "", ylab="Global Active Power (Kilowatts)")

## Plot 3
plot(sub_data$Date_Time,sub_data$Sub_metering_1, type="n", xlab="", ylab = "Energy sub metering")
with(sub_data,lines(Date_Time,Sub_metering_1))
with(sub_data,lines(Date_Time,Sub_metering_2, col="red"))
with(sub_data,lines(Date_Time,Sub_metering_3, col="blue"))
legend("topright", lty=1,  col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## Plot 4
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

