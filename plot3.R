library("data.table")
library("dplyr")

hpc_data <- data.table::fread(
    input = "household_power_consumption_safe.txt",
    na.strings = "?"
)

View(hpc_data)

# Making a POSIXct date capable of beign filtered and graphed by time of day.
hpc_data[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filtering dates for 2007-02-01 and 2007-02-02.
hpc_data <- filter(hpc_data,
                   dateTime >= "2007-02-01" & dateTime < "2007-02-03")
# PLotting
png("plot3.png",width=480,height=480)

plot(
    hpc_data$dateTime, hpc_data$Sub_metering_1, 
    type = "l", xlab="",ylab="Energy sub metering"
)
lines(hpc_data$dateTime,hpc_data$Sub_metering_2,col="red")
lines(hpc_data$dateTime,hpc_data$Sub_metering_3,col="blue")

legend("topright",
       col=c("black","red","blue"),
       c("Sub_metering_1 ","Sub_metering_2 ","Sub_metering_3 "),
       lty=c(1,1),lwd=c(1,1)
       
       )
dev.off()
