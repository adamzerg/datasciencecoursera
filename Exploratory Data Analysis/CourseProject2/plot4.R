library(data.table)
library(ggplot2)
library(gridExtra)

## 1. Download source data

download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
              , 'exdata.zip'
              , method='curl' )
unzip("exdata.zip", files = NULL, exdir=".")

## 2. Load Data

SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

## 3. Explore data set and filter for coal-combustion realted SCC

summary(SCC)
summary(NEI)
#View(SCC)

dff <- SCC[SCC$Short.Name %like% "Coal" |
      SCC$EI.Sector %like% "Coal" |
      SCC$SCC.Level.One %like% "Coal" |
      SCC$SCC.Level.Two %like% "Coal" |
      SCC$SCC.Level.Three %like% "Coal" |
      SCC$SCC.Level.Four %like% "Coal", ]

## 4. Aggregate data set by year

dfa <- NEI[NEI$SCC %in% dff$SCC, ] %>% 
      group_by(year, type) %>%
      summarise(sum = sum(Emissions, na.rm = TRUE),
      mean = mean(Emissions, na.rm = TRUE),
      median = median(Emissions, na.rm = TRUE),
      min = min(Emissions, na.rm = TRUE),
      max = max(Emissions, na.rm = TRUE),
      .groups = "drop")

## 5. Plotting

png(file="plot4.png", width = 1920, height = 640, res=120)
theme(text = element_text(size = 5, family="Serif"))

g1 <- ggplot(dfa, aes(x = year, y = sum, color = sum)) +
  geom_line() +
  facet_wrap(~type, nrow = 1, ncol = 4) +
  xlab("Source types") + ylab("Total of PM2.5 emissions")

g2 <- ggplot(NEI[NEI$SCC %in% dff$SCC, ], aes(x = factor(year), y = log10(Emissions), fill = factor(year))) +
  geom_boxplot() +
  facet_wrap(~type, nrow = 1, ncol = 4) +
  xlab("Source types") + ylab("Log10 of PM2.5")

grid.arrange(g1, g2, nrow = 1, top = "PM2.5 emissions over coal combustion source")
dev.off()