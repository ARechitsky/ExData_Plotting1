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

submetering <- paste("Sub_metering_", 1:3, sep = "")
ymin <- NA
ymax <- NA
for (i in 1:3) {
  data[,submetering[i]] <- as.numeric(as.character(data[,submetering[i]]))
  ymin <- min(ymin, data[,submetering[i]], na.rm = TRUE)
  ymax <- max(ymax, data[,submetering[i]], na.rm = TRUE)
}

png("plot3.png")
colors <- c("black","blue","red")
plot(range(data$DateTime), c(ymin, ymax),
     type = "n",
     xlab = "",
     ylab = "Energy sub metering")
for (i in 1:3) {
    lines(data$DateTime, data[,columns[i]], col = colors[i])
}
legend("topright", submetering, col = colors, lty = 1)
dev.off()
