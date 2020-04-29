# Read in the dataset
power <- read.table('../Course4_ExploratoryDataAnalysis/data/household_power_consumption.txt', header = TRUE, sep = ';', dec ='.' )

#Restrict data to the dates 2007-02-01 to 2007-02-02
power$Date <- strptime(power$Date,"%d/%m/%Y")
power$Date <- as.Date(power$Date)
power_clean <- subset(power,Date == '2007-02-01' | Date == '2007-02-02')
rownames(power_clean) <- NULL #reset row numbers

#Create new datetime variable 
library(lubridate)
power_clean$DateTime <- with(power_clean, ymd(Date)+hms(Time))

#Convert Global_active_power, Sub_metering columns to numeric 
#(for some reason read.table would not work when tried to specify colClasses)
power_clean$Global_active_power <- as.numeric(paste(power_clean$Global_active_power))
power_clean$Sub_metering_1 <- as.numeric(paste(power_clean$Sub_metering_1))
power_clean$Sub_metering_2 <- as.numeric(paste(power_clean$Sub_metering_2))
power_clean$Sub_metering_3 <- as.numeric(paste(power_clean$Sub_metering_3))


png(file = 'plot4.png', width=480, height = 480) #open plotting device
par(mfcol = c(2,2)) #set plot window to be 2x2, adding plots by column

#Global Active power line plot (plot2.R)
with(power_clean, plot(x=DateTime, y = Global_active_power, xlab ="", ylab = "Global Active Power (kilowatts)", type = "l",lwd = 1))

#Create line plot of Sub Metering data (plot3.R)
with(power_clean, plot(DateTime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy to sub metering"))
with(power_clean, lines(x=DateTime, y = Sub_metering_1,xlab = "", ylab = "Energy to sub metering", type = "l",lwd = 1))
with(power_clean, lines(x=DateTime, y = Sub_metering_2, xlab ="", type = "l",lwd = 1, col = "red"))
with(power_clean, lines(x=DateTime, y = Sub_metering_3, xlab ="", type = "l",lwd = 1, col = "blue"))
legend("topright", lwd = 1, col = c("black", "red","blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), bty = "n")

#Voltage line plot
with(power_clean, plot(x=DateTime, y = Voltage, xlab ="datetime", ylab = "Voltage", type = "l",lwd = 1))

#Global Reactive power line plot
with(power_clean, plot(x=DateTime, y = Global_reactive_power, xlab ="datetime", ylab = "Global_reactive_power", type = "l",lwd = 1))

dev.off()
