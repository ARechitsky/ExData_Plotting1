Sys.setlocale("LC_ALL","English")

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","data.zip")
unzip("data.zip")
rowscount = 100000 #enough for 2007-02-01 and 2007-02-02
data <- read.csv("household_power_consumption.txt", sep = ';',nrows = rowscount)
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")
bounds <- as.Date(c("2007-02-01","2007-02-02"))
data <- data[data$Date <= bounds[2] & data$Date >= bounds[1], ]
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- strptime(data$DateTime, "%Y-%m-%d %H:%M:%S")

png("plot2.png")
plot(data$DateTime, data$Global_active_power, 
     type = "l",
     col = "black",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()
