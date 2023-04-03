library("data.table")
library("dplyr")

hpc_data <- data.table::fread(
    input = "household_power_consumption_safe.txt",
    na.strings = "?"
)

View(hpc_data)

# Changing the date format.
hpc_data[,Date:=lapply(.SD, as.Date,"%d/%m/%Y"),.SDcols = c("Date")]

# Filter Dates for 2007-02-01 and 2007-02-02
hpc_data <- filter(hpc_data,Date >= "2007-02-01" & Date <= "2007-02-02")

# plotting

# plotting1
png("plot1.png",width = 480, height = 480)
hist(hpc_data$Global_active_power,main="Global Active Power",
     xlab="Global Active Power (kilowatt)",ylab="Frequency",col="Red")
dev.off()

