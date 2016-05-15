# Read data from txt file
all_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";"
                       , check.names=F, stringsAsFactors=F, comment.char="", quote='\"', dec = ".")

#Convert date format
all_data$Date <- as.Date(all_data$Date, format="%d/%m/%Y")

#Filter only the required data of dates 2007-02-01 and 2007-02-02
subset_data <- subset(all_data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

#Remove the initial huge dataset that's no more required
rm(all_data)

# Convert Global_active_power to numeric
globalActivePower <- as.numeric(subset_data$Global_active_power)

#Convert datetime as POSIXct
datetime <- paste(as.Date(subset_data$Date), subset_data$Time)
subset_data$Datetime <- as.POSIXct(datetime)

## Plot 2
plot(globalActivePower~Datetime, data = subset_data, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()