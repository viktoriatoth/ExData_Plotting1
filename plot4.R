#Importing data
pdata <- read.table("household_power_consumption.txt", header = T, sep = ";"
                    ,colClasses = c("character", "character","numeric","numeric","numeric", "numeric","numeric"                                             ,"numeric","numeric")
                    ,na.strings="?"
) 


# changing  pdata$Date into Date format
pdata[,1]  <- as.Date(pdata[,1], "%d/%m/%Y")

#selecting the dates we're interested in
pdata  <- pdata [which (pdata$Date== "2007-02-01" | pdata$Date== "2007-02-02") ,]

# changing pdata$Time into time format
pdata["datetime"] <- NA
pdata$datetime <- paste(pdata$Date , pdata$Time, sep=" ")
pdata$datetime  <- as.POSIXct(strptime(pdata$datetime , format = "%Y-%m-%d %H:%M:%S"),"%Y-%m-%d %H:%M:%S", tz ="CET")


# creating the 2x2 canvas
png("plot4.png", width = 480, height = 480)

par(mfrow= c(2,2))
# first plot at the first row, left side
plot( pdata$Global_active_power ~ pdata$datetime,type = "n", ylab = "Global Active Power (kilowatts)",  xlab ="")
lines(pdata$Global_active_power ~ pdata$datetime )

# first row, rigth side plot
plot(pdata$Voltage ~ pdata$datetime, type = "n",  ylab = "Voltage", xlab ="datetime")
lines(pdata$Voltage ~ pdata$datetime)

# second row, left side plot
plot(pdata$Sub_metering_1 ~ pdata$datetime, type = "n", ylab = "Energy sub metering", xlab ="")
lines(pdata$Sub_metering_1 ~ pdata$datetime)
lines( pdata$Sub_metering_2~ pdata$datetime, col = "red")
lines( pdata$Sub_metering_3~ pdata$datetime, col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = c(1,1,1), col = c("black","red","blue"))

# second row, right side plot
plot(pdata$Global_reactive_power ~ pdata$datetime, type = "n", ylab = "Global reactive power", xlab ="datetime")
lines(pdata$Global_reactive_power ~ pdata$datetime)

dev.off()

par(mfrow=c(1,1))