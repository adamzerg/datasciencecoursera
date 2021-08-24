#install.packages("dplyr")
library(dplyr)
library(ggplot2)
library(gridExtra)

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

dfa <- NEI[NEI$fips == "24510", ] %>% 
      group_by(year, type) %>%
      summarise(sum = sum(Emissions, na.rm = TRUE),
      mean = mean(Emissions, na.rm = TRUE),
      median = median(Emissions, na.rm = TRUE),
      min = min(Emissions, na.rm = TRUE),
      max = max(Emissions, na.rm = TRUE),
      .groups = "drop")

## 5. Plotting

png(file="plot3.png", width = 1920, height = 640, res=120)
theme(text = element_text(size = 5, family="Serif"))

g1 <- ggplot(dfa, aes(x = year, y = sum, color = sum)) +
  geom_line() +
  facet_wrap(~type, nrow = 1, ncol = 4) +
  #ggtitle("Total PM2.5 emissions over source types (Baltimore)") +
  xlab("Source types") + ylab("Total of PM2.5 emissions")

g2 <- ggplot(NEI[NEI$fips == "24510", ], aes(x = factor(year), y = log10(Emissions), fill = factor(year))) +
  geom_boxplot() +
  facet_wrap(~type, nrow = 1, ncol = 4) +
  #ggtitle("PM2.5 emissions over source types (Baltimore)") + 
  xlab("Source types") + ylab("Log10 of PM2.5")

grid.arrange(g1, g2, nrow = 1, top = "PM2.5 emissions over source types (Baltimore)")
dev.off()