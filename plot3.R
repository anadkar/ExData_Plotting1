## Read sample from data to determine column names

samp <-read.table("./household_power_consumption.txt", sep=";",header=TRUE, 
                  nrows=10)

## Extract column names
headers <- colnames(samp)

#Read part of data where required data is present. 
##This was determined through trial and error. 
##This process will strip out column names due to the "skip" option

power <- read.table("./household_power_consumption.txt", sep=";", 
                    skip =60000, stringsAsFactors= FALSE,
                    nrows=10000)

## Apply previously obtained column names
names(power) <- headers

## Combine date and time variables using paste() function and 
## convert to POSIXct using strptime()

power$Date <- strptime(paste(power$Date,power$Time), "%d/%m/%Y %H:%M:%S")

## Subset data to use only Feb 1, 2007 and Feb2, 2007

ds <- power[power$Date >= "2007-02-01" & power$Date < "2007-02-03",]


## Open PNG device
png(file="plot3.png")

## Plot per specifications

 with(ds, plot(Date, Sub_metering_1, type ="l", xlab="", ylab="Energy sub metering"))
 with(ds, lines(Date, Sub_metering_2, col="red"))
 with(ds, lines(Date, Sub_metering_3, col="blue"))
legend('topright', names(ds)[c(7, 8, 9)], col= c('black', 'red', 'blue'), lty=1)

dev.off()
