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
# changing pdata$Time into time format
pdata["datetime"] <- NA
pdata$datetime <- paste(pdata$Date , pdata$Time, sep=" ")
pdata$datetime  <- as.POSIXct(strptime(pdata$datetime , format = "%Y-%d-%m %H:%M:%S"),"%Y-%d-%m %H:%M:%S", tz ="CET")

par(mfrow = c(1,1))

# creating the plot
png("plot2.png", width = 480, height = 480)
plot( pdata$Global_active_power ~ pdata$datetime,type = "n", ylab = "Global Active Power (kilowatts)",  xlab ="")
lines(pdata$Global_active_power ~ pdata$datetime )


# save as PNG
png("plot2.png", width = 480, height = 480)
dev.copy(png,'plot2.png', width = 480, height = 480)
dev.off()