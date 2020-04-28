# Read in the dataset
power <- read.table('../Course4_ExploratoryDataAnalysis/data/household_power_consumption.txt', header = TRUE, sep = ';', dec ='.')

#Restrict data to the dates 2007-02-01 to 2007-02-02
power$Date <- strptime(power$Date,"%d/%m/%Y")
power$Date <- as.Date(power$Date)
power_clean <- subset(power,Date == '2007-02-01' | Date == '2007-02-02')

#Create line plot of Global Active Power
with(power_clean, plot(x = Date, y = Global_active_power, ylab = "Global Active Power (kilowatts)"))
