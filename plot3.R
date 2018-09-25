#plot3
#creating the folders
if(!file.exists("./Explore1")){dir.create("./Explore1")}
if(!file.exists("./Explore1/Code")){dir.create("./Explore1/Code")}
setwd("./Explore1/Code")
if(!file.exists("../Data")){dir.create("../Data")}
if(!file.exists("../Results")){dir.create("../Results")}

#0: download file and unzip
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileLocation <- "../Data/Dataset.zip"
download.file(fileURL, destfile = fileLocation)
unzip(zipfile = fileLocation, exdir="../Data")

#1: Load file and 
housepower <- read.table("../Data/household_power_consumption.txt",
                         skip=1,sep=";")
names(housepower) <- c("Date","Time","Global_active_power",
                       "Global_reactive_power","Voltage","Global_intensity",
                       "Sub_metering_1","Sub_metering_2","Sub_metering_3")

spower <- subset(housepower,housepower$Date=="1/2/2007" | housepower$Date =="2/2/2007")
spower$Date <- as.Date(spower$Date, format="%d/%m/%Y")
spower$Time <- strptime(spower$Time, format="%H:%M:%S")
spower[1:1440,"Time"] <- format(spower[1:1440,"Time"],"2007-02-01 %H:%M:%S")
spower[1441:2880,"Time"] <- format(spower[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

spower$Sub_metering_1 <- as.numeric(as.character(spower$Sub_metering_1))
spower$Sub_metering_2 <- as.numeric(as.character(spower$Sub_metering_2))
spower$Sub_metering_3 <- as.numeric(as.character(spower$Sub_metering_3))

#2: actually plotting
with(spower, plot(Time, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering", main = "Energy sub-metering"))
with(spower, lines(Time, Sub_metering_1))
with(spower, lines(Time, Sub_metering_2,col="red"))
with(spower, lines(Time, Sub_metering_3,col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.copy(png, file = "../Results/plot3.png")
dev.off()