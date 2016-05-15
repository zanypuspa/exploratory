# Read data from txt file
all_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";"
                       , check.names=F, stringsAsFactors=F, comment.char="", quote='\"', dec = ".")

#Convert date format
all_data$Date <- as.Date(all_data$Date, format="%d/%m/%Y")

#Filter only the required data of dates 2007-02-01 and 2007-02-02
subset_data <- subset(all_data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

#Remove the initial huge dataset that's no more required
rm(all_data)

# Convert to numeric
globalActivePower <- as.numeric(subset_data$Global_active_power)
voltage <- as.numeric(subset_data$Voltage)
globalReactivePwr <- as.numeric(subset_data$Global_reactive_power)
subMtr1 <- as.numeric(subset_data$Sub_metering_1)
subMtr2 <- as.numeric(subset_data$Sub_metering_2)
subMtr3 <- as.numeric(subset_data$Sub_metering_3)

#Convert datetime as POSIXct
datetime <- paste(as.Date(subset_data$Date), subset_data$Time)
subset_data$Datetime <- as.POSIXct(datetime)

par(mfrow = c(2, 2), mar=c(4,4,2,1), oma=c(0,0,2,0))

## Plot 1
plot(globalActivePower~Datetime, data = subset_data, type="l", ylab="Global Active Power", xlab="")

## Plot 2
plot(voltage~Datetime, data = subset_data, type="l", ylab="Voltage", xlab="datetime")

## Plot 3
plot(subMtr1~Datetime, data = subset_data, type="l", ylab="Energy sub metering", xlab="")
lines(subMtr2~Datetime, data = subset_data, type="l", col = "red")
lines(subMtr3~Datetime, data = subset_data, type="l", col = "blue")
legend("topright", col = c("black","red","blue"), lty = 1, lwd = 2, bty="n", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## Plot 4
plot(globalReactivePwr~Datetime, data = subset_data, type="l", ylab="Global_reactive_power", xlab="datetime")
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()