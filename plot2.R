#Importing data
pdata <- read.table("household_power_consumption.txt", header = T, sep = ";"
                    ,colClasses = c("character", "character","numeric","numeric","numeric", "numeric","numeric"                                             ,"numeric","numeric")
                    ,na.strings="?"
)        

# changing  pdata$Date into Date format
pdata[,1]  <- as.Date(pdata[,1], "%d/%m/%Y")

#selecting the dates we're interested in
pdata  <- pdata [which (pdata$Date== "2007-02-01" | pdata$Date== "2007-02-02") ,]

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


# creating the plot
png("plot2.png", width = 480, height = 480)
plot( pdata$Global_active_power ~ pdata$datetime,type = "n", ylab = "Global Active Power (kilowatts)",  xlab ="")
lines(pdata$Global_active_power ~ pdata$datetime )


# save as PNG
png("plot2.png", width = 480, height = 480)
dev.copy(png,'plot2.png', width = 480, height = 480)
dev.off()