# install.packages("dplyr")
# install.packages("plyr")
# install.packages("tidyr")

library(dplyr)
# library(plyr)
# library(reshape2)

## 1. Download source data

download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
              , 'household_power_consumption.zip'
              , method='curl' )

unzip("household_power_consumption.zip", files = NULL, exdir=".")
getwd()
dir()

## 2. Load Data

power_consumption <- read.table(header = TRUE,sep = ";","household_power_consumption.txt")

## 3. Explore data set

nrow(power_consumption)
head(power_consumption)
# View(power_consumption)

## 4. Format data type

power_consumption$Date <-as.Date(power_consumption$Date,"%d/%m/%Y")
sample <- filter(power_consumption,Date>='2007-02-01'&Date<='2007-02-02')

