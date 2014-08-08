samp <-read.table("./household_power_consumption.txt", sep=";",header=TRUE, 
                  nrows=10)

headers <- colnames(samp)

power <- read.table("./household_power_consumption.txt", sep=";", 
                    skip =60000, stringsAsFactors= FALSE,
                    nrows=10000)

names(power) <- headers

power$Date <- strptime(paste(power$Date,power$Time), "%d/%m/%Y %H:%M:%S")

ds <- power[power$Date >= "2007-02-01" & power$Date < "2007-02-03",]

ds$Global_active_power <- as.numeric(ds$Global_active_power)

png(file="plot1.png")

with(ds, hist(Global_active_power, col= "red", 
              xlab="Global Active Power (kilowatts)", 
              main= "Global Active Power"))
dev.off()
