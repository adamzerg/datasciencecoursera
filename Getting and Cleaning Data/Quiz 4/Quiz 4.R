download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
              , 'ACS.csv'
              , method='curl' )
ACS <- read.csv('ACS.csv')


download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
              , 'GDP.csv'
              , method='curl' )
GDP <- read.csv('GDP.csv', nrow = 190, skip = 4)
GDP<-GDP[c(1,2,4,5)]
colnames(GDP) <- c("CountryCode","Rank","Country","Total")
mean(as.integer(gsub(",","",GDP$Total)), na.rm = T)

grep("^United", GDP$Country)



download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'
              , 'Edu.csv'
              , method='curl' )
Edu <- read.csv('Edu.csv')

length(grep("Fiscal year end: June", merge(GDP,Edu,"CountryCode")$'Special.Notes'))

merged <- merge(GDP,Edu,"CountryCode")
grep("Fiscal year end: June", merged$'Special.Notes')


install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

length(sampleTimes[grep("^2012", sampleTimes)])


amzn2012 <- sampleTimes[grep("^2012", sampleTimes)]
NROW(amzn2012)
NROW(amzn2012[weekdays(amzn2012) == "ÐÇÆÚÒ»"])
