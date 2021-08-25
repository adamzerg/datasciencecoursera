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

## 3. Explore data set and filter for On-Road type Vehicle SCC

summary(SCC)
summary(NEI)
#View(SCC)

dff <- SCC[SCC$Data.Category %like% "Onroad" & (
      SCC$Short.Name %like% "Vehicle" |
      SCC$EI.Sector %like% "Vehicle" |
      SCC$SCC.Level.One %like% "Vehicle" |
      SCC$SCC.Level.Two %like% "Vehicle" |
      SCC$SCC.Level.Three %like% "Vehicle" |
      SCC$SCC.Level.Four %like% "Vehicle"), ]

fips <- data.frame(fips = c("24510","06037"), city = c("Baltimore","Los Angeles"))

df <- merge(NEI[NEI$SCC %in% dff$SCC & NEI$fips %in% c("24510","06037"), ]
        ,fips)

## 4. Aggregate data set by year

dfa <- df %>% 
      group_by(year, city) %>%
      summarise(sum = sum(Emissions, na.rm = TRUE),
      mean = mean(Emissions, na.rm = TRUE),
      median = median(Emissions, na.rm = TRUE),
      min = min(Emissions, na.rm = TRUE),
      max = max(Emissions, na.rm = TRUE),
      .groups = "drop")

## 5. Plotting

png(file="plot6.png", width = 1920, height = 640, res=120)
theme(text = element_text(size = 5, family="Serif"))

g1 <- ggplot(dfa, aes(x = year, y = sum, color = city)) +
  geom_line() +
  facet_wrap(~city, nrow = 1, ncol = 4) +
  xlab("Year") + ylab("Total of PM2.5 emissions")

g2 <- ggplot(df, aes(x = factor(year), y = log10(Emissions), fill = factor(year))) +
  geom_boxplot() +
  facet_wrap(~city, nrow = 1, ncol = 4) +
  xlab("Year") + ylab("Log10 of PM2.5")

grid.arrange(g1, g2, nrow = 1, top = "PM2.5 emissions to motor vehicle (Baltimore vs Los Angeles)")
dev.off()