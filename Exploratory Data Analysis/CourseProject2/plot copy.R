#install.packages("dplyr")
#library(dplyr)
#library(datasets)

## 1. Download source data

download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
              , 'exdata.zip'
              , method='curl' )
unzip("exdata.zip", files = NULL, exdir=".")

## 2. Load Data

SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

## 3. Explore data set

summary(SCC)
summary(NEI)

#View(SCC)
#head(NEI)

## 4. Aggregate data set by year

x <- NEI %>% 
      group_by(year) %>% 
      summarise(sum = sum(Emissions, na.rm = TRUE),
      mean = mean(Emissions, na.rm = TRUE),
      median = median(Emissions, na.rm = TRUE),
      min = min(Emissions, na.rm = TRUE),
      max = max(Emissions, na.rm = TRUE))

y1 <- NEI$Emissions[NEI$year == 1999]
y2 <- NEI$Emissions[NEI$year == 2002]
y3 <- NEI$Emissions[NEI$year == 2005]
y4 <- NEI$Emissions[NEI$year == 2008]

## 5. Plotting

png(file="plot1.png", width = 1280, height = 640, res=120)
par(mfrow=c(1,2))
plot(x$year,x$sum/1000000,
      xlab="Year",
      ylab="Total PM2.5 in megatons",
      type="l")
boxplot(log10(y1), log10(y2), log10(y3), log10(y4),
      names=c("1999","2002","2005","2008"),
      xlab="Year",
      ylab="Log10 of PM2.5")
mtext("PM2.5 Emissions over years", side= 3, line=-2, outer = TRUE)
dev.off()



power_consumption <- read.table(header = TRUE,sep = ";","household_power_consumption.txt")
power_consumption$Date <- as.Date(power_consumption$Date,"%d/%m/%Y")
dt <- filter(power_consumption, Date >= '2007-02-01' & Date <= '2007-02-02')
dt$Global_active_power <- as.numeric(as.character(dt$Global_active_power))
dt$Global_reactive_power <- as.numeric(as.character(dt$Global_reactive_power))
dt$Voltage <- as.numeric(as.character(dt$Voltage))
dt$Sub_metering_1 <- as.numeric(as.character(dt$Sub_metering_1))
dt$Sub_metering_2 <- as.numeric(as.character(dt$Sub_metering_2))
dt$Sub_metering_3 <- as.numeric(as.character(dt$Sub_metering_3))
dt$DateTime <- strptime(paste(dt$Date,dt$Time), format="%Y-%m-%d %H:%M:%S")


## 5. Plotting

png(file="plot4.png")
par(mfrow=c(2,2))
plot(dt$DateTime, type="l", dt$Global_active_power, xlab = NA, ylab="Global Active Power")
plot(dt$DateTime, type="l", dt$Voltage, xlab = "datetime", ylab="Voltage")
plot(dt$DateTime, dt$Sub_metering_1, type="l", xlab=NA, ylab="Energy sub metering")
lines(dt$DateTime, dt$Sub_metering_2, col = "red")
lines(dt$DateTime, dt$Sub_metering_3, col = "blue")
legend("topright",cex=0.8,lwd=c(1,1,1),bty="n",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
plot(dt$DateTime, type="l", dt$Global_reactive_power, xlab = "datetime")
dev.off()