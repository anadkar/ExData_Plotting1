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

par(mfrow=c(2,2))

png(file="plot4.png")

par(mfrow=c(2,2))

with(ds, {
        
     plot(Date, Global_active_power, type="l", 
              xlab="", ylab="Global Active Power")
     plot(Date, Voltage, type ="l", xlab="datetime")
     plot(Date, Sub_metering_1, type ="l", xlab="", ylab="Energy sub metering")
     lines(Date, Sub_metering_2, col="red")
     lines(Date, Sub_metering_3, col="blue")
     legend('topright', names(ds)[c(7, 8, 9)], col= c('black', 'red', 'blue'), 
             lty=1, bty="n")
     plot(Date, Global_reactive_power, type="l",
          xlab="datetime")
 })

dev.off()