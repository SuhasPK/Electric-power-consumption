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
png("plot2.png",width=480,height=480)

plot(x = hpc_data$dateTime, y = hpc_data$Global_active_power,
     type = "l",
     xlab="", 
     ylab = "Global Active Power (kilowatts")
dev.off()
