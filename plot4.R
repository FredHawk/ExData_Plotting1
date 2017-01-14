## Get the whole dataset
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data_all <-read.table(unz(temp, "household_power_consumption.txt"), header=TRUE, sep=";", na.strings = "?")
unlink(temp)

## Change the date format
data_all$Date <- as.Date(data_all$Date, format="%d/%m/%Y")

## Subset to get only the 1st and 2nd of febuary of 2007
data <- subset(data_all, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## Convert the dates and times.
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Make the plot
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(data, {
  plot(Global_active_power~Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Datetime, type="l", ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~Datetime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
  lines(Sub_metering_2~Datetime, col = "Red")
  lines(Sub_metering_3~Datetime, col = "Blue")
  legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type = "l", ylab = "Global Reactive Power (kilowatts)", xlab = "")
})

## Save to .png
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()