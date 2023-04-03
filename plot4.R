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
png("plot4.png",width=480,height=480)

# Making sapce for 4 plots in one pic.
par(mfrow = c(2,2))

# plot1
plot(hpc_data$dateTime,hpc_data$Global_active_power,
     type="l",xlab="",ylab="Global Active Power (kilowatts)")
#plot2
plot(hpc_data$dateTime,hpc_data$Voltage,type="l",
     xlab = "dateTime",ylab="Voltage")
#plot3
plot(hpc_data$dateTime,hpc_data$Sub_metering_1,
     type = "l", xlab = "",ylab="Energy sub metering")
lines(hpc_data$dateTime,hpc_data$Sub_metering_2,col="red")
lines(hpc_data$dateTime,hpc_data$Sub_metering_3,col="blue")
legend("topright", col = c("black","red","blue"),
    c("Sub_metering_1 ","Sub_metering_2 ","Sub_metering_3 "),
    lty=c(1,1),
    bty="n",
    cex=0.5
)
#plot4
plot(hpc_data$dateTime,hpc_data$Global_reactive_power,
     type="l",
     xlab="dateTime", ylab="Global_reactive_power")
dev.off()
