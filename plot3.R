#Importing data
pdata <- read.table("household_power_consumption.txt", header = T, sep = ";"
                    ,colClasses = c("character", "character","numeric","numeric","numeric", "numeric","numeric"                                             ,"numeric","numeric")
                    ,na.strings="?"
) 


# changing  pdata$Date into Date format
pdata[,1]  <- as.Date(pdata[,1], "%d/%m/%Y")

#selecting the dates we're interested in
pdata  <- pdata [which (pdata$Date== "2007-02-01" | pdata$Date== "2007-02-02") ,]


# I create a new datetime column to store Date and Time values
pdata["datetime"] <- NA
# concatenating Date and Time
pdata$datetime <- paste(pdata$Date , pdata$Time, sep=" ") 
# updating the new datetime column as POSIXct format 
pdata$datetime  <- as.POSIXct(strptime(pdata$datetime , format = "%Y-%m-%d %H:%M:%S"),"%Y-%m-%d %H:%M:%S", tz ="CET")

# first I create the plot
plot(pdata$Sub_metering_1 ~ pdata$datetime, type = "n", ylab = "Energy sub metering", xlab ="")
lines(pdata$Sub_metering_1 ~ pdata$datetime)
lines( pdata$Sub_metering_2~ pdata$datetime, col = "red")
lines( pdata$Sub_metering_3~ pdata$datetime, col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = c(1,1,1), col = c("black","red","blue"))

dev.off()

# then I save the plot
png("plot3.png", width = 480, height = 480)
plot(pdata$Sub_metering_1 ~ pdata$datetime, type = "n", ylab = "Energy sub metering", xlab ="")
lines(pdata$Sub_metering_1 ~ pdata$datetime)
lines( pdata$Sub_metering_2~ pdata$datetime, col = "red")
lines( pdata$Sub_metering_3~ pdata$datetime, col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = c(1,1,1), col = c("black","red","blue"))

dev.off()