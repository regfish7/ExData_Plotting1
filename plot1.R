# Read in the dataset
power <- read.table('../Course4_ExploratoryDataAnalysis/data/household_power_consumption.txt', header = TRUE, sep = ';', dec ='.')

#Restrict data to the dates 2007-02-01 to 2007-02-02
power$Date <- strptime(power$Date,"%d/%m/%Y")
power$Date <- as.Date(power$Date)
power_clean <- subset(power,Date == '2007-02-01' | Date == '2007-02-02')

#Create histogram of Global Active Power 

#Note that Global_active_power must first be converted from a factor to numeric class
power_clean$Global_active_power <- as.numeric(paste(power_clean$Global_active_power))

options(scipen=999) #turn off scientific notation on the y axis
with(power_clean, hist(Global_active_power, col = "red", breaks = 24, main = "Global Active Power", 
                 xlab = 'Global Active Power (kilowatts)')) # xlim=c(0,6), ylim = c(0,1200)

#Copy plot to png file
dev.copy(png,file ='plot1.png')
dev.off()
