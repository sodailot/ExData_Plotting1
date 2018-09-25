#plot1
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

#1: Load file and subset
housepower <- read.table("../Data/household_power_consumption.txt",
                         skip=1,sep=";")
names(housepower) <- c("Date","Time","Global_active_power",
                       "Global_reactive_power","Voltage","Global_intensity",
                       "Sub_metering_1","Sub_metering_2","Sub_metering_3")

spower <- subset(housepower,housepower$Date=="1/2/2007" | housepower$Date =="2/2/2007")
spower$Global_active_power <- as.numeric(as.character(spower$Global_active_power))

#2: actually plotting
with(spower, hist((Global_active_power),col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)"))
dev.copy(png, file = "../Results/plot1.png")
dev.off()