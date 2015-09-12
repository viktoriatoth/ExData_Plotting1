
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


# creating the plot
png("plot1.png", width = 480, height = 480)
hist(pdata[,3], col = "red", main = "Global Active power", xlab = "Global Active Power(kilowatts)")

dev.off()