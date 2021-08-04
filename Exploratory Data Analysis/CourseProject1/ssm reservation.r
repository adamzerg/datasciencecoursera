install.packages("tidyverse")
install.packages("dplyr")
library(dplyr)
library(readxl)
#libraryq(xlsx)

download.file('https://www.ssm.gov.mo/docs/stat/apt/RNA010.xlsx', 'RNA010.xlsx', method='curl' )
rdf <- read_excel("RNA010.xlsx", sheet="20210804", na = "---")
rdf1 <- rdf %>% select(c(2,4:ncol(rdf))) %>% slice(4:nrow(rdf))
rdf <- read_excel("RNA010.xlsx", sheet="20210805", na = "---")
rdf2 <- rdf %>% select(c(2,4:ncol(rdf))) %>% slice(3:nrow(rdf))
rdf <- read_excel("RNA010.xlsx", sheet="20210806", na = "---")
rdf3 <- rdf %>% select(c(2,4:ncol(rdf))) %>% slice(3:nrow(rdf))
rdf <- read_excel("RNA010.xlsx", sheet="20210807", na = "---")
rdf4 <- rdf %>% select(c(2,4:ncol(rdf))) %>% slice(3:nrow(rdf))
rdf1$ReservationDate <- "2021-08-04"
rdf2$ReservationDate <- "2021-08-05"
rdf3$ReservationDate <- "2021-08-06"
rdf4$ReservationDate <- "2021-08-07"
df <- rbind(rdf1,rdf2,rdf3,rdf4)
df$ReservationTime <- substr(df$預約時段,1,5)
df$ReservationDateTime <- paste (df$ReservationDate, df$ReservationTime)
df <- df[, 2:ncol(df)]
data <- as.data.frame(df)
dfm <- melt(data, id = c("ReservationDateTime", "ReservationDate", "ReservationTime"))
#dfm[is.na(dfm)] <- 0
#dfn <- filter(dfm, variable == "澳門大學", value < quantile(dfm$value, 0.90, na.rm=TRUE))

g <- ggplot(dfm, aes(ReservationTime,value,colour = ReservationDate))
g + geom_point() + facet_wrap(~variable, nrow = 6, ncol = 7)

