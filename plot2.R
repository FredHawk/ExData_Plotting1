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
plot(data$Global_active_power~data$Datetime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

## Save to .png
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()