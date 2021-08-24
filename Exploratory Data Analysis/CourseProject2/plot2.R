#install.packages("dplyr")
library(dplyr)

## 1. Download source data

download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
              , 'exdata.zip'
              , method='curl' )
unzip("exdata.zip", files = NULL, exdir=".")

## 2. Load Data

NEI <- readRDS("summarySCC_PM25.rds")

## 3. Explore data set

summary(NEI)
#head(NEI)

## 4. Aggregate data set by year (Baltimore 24510)

x <- NEI[NEI$fips == "24510",] %>% 
      group_by(year) %>% 
      summarise(sum = sum(Emissions, na.rm = TRUE),
      mean = mean(Emissions, na.rm = TRUE),
      median = median(Emissions, na.rm = TRUE),
      min = min(Emissions, na.rm = TRUE),
      max = max(Emissions, na.rm = TRUE))

y1 <- NEI$Emissions[NEI$fips == "24510" & NEI$year == 1999]
y2 <- NEI$Emissions[NEI$fips == "24510" & NEI$year == 2002]
y3 <- NEI$Emissions[NEI$fips == "24510" & NEI$year == 2005]
y4 <- NEI$Emissions[NEI$fips == "24510" & NEI$year == 2008]

## 5. Plotting

png(file="plot2.png", width = 1280, height = 640, res=120)
par(mfrow=c(1,2))
plot(x$year,x$sum/1000,
      xlab="Year",
      ylab="Total PM2.5 in kilotons",
      type="l")
boxplot(log10(y1), log10(y2), log10(y3), log10(y4),
      names=c("1999","2002","2005","2008"),
      xlab="Year",
      ylab="Log10 of PM2.5")
mtext("PM2.5 emissions over years (Baltimore)", side= 3, line=-2, outer = TRUE)
dev.off()