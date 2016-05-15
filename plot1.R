# Read data from txt file
all_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";"
, check.names=F, stringsAsFactors=F, comment.char="", quote='\"', dec = ".")

#Convert date format
all_data$Date <- as.Date(all_data$Date, format="%d/%m/%Y")

#Filter only the required data of dates 2007-02-01 and 2007-02-02
subset_data <- subset(all_data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

#Remove the initial huge dataset that's no more required
rm(all_data)

#Plot 1 begins here
#Cast Global_active_power as number
globalActivePower <- as.numeric(subset_data$Global_active_power)
hist(globalActivePower, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", col = "red")
dev.copy(png, file = "plot1.png", height=480, width=480)
dev.off()
