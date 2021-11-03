#install.packages("R.utils")
#install.packages("tidyverse")
#install.packages("treemap")
#install.packages("remotes")
#remotes::install_github("d3treeR/d3treeR")
#install.packages("reshape2")
#install.packages('ggmap')
#install.packages('plotly')
#install.packages("GGally")

# this sets your google map for this session
# register_google(key = "AIzaSyD9z90fvzxmOhRzoNbxbwOmuIXI6CVKcTE")
# ggmap_hide_api_key()


library(R.utils)
library(readr)
library(tidyr)
library(lubridate)
library(stringr)
library(dplyr)
library(ggplot2)
library(reshape2)
library(gridExtra)
library(treemap)
library(d3treeR)
library(ggmap)
library(plotly)
library(GGally)
 

download.file('https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2', 'storm.csv.bz2', method='curl' )
bunzip2(filename="storm.csv.bz2", "storm.csv")
#storm <- read.csv("storm.csv", header = TRUE, sep = ",", quote = "", stringsAsFactors = FALSE)
storm <- read_csv("storm.csv", col_name = TRUE)
# Event table is pulled from the document, contains of 48 event types
evnt_tbl <- read_csv("storm-data-event-table.csv", col_name = TRUE)
state_tbl <- read_csv("state.csv", col_name = TRUE)


## Data Processing

# Some assumptions are made here according to the documentation
# for example, Landslide / Landslump / Mudslide are categorized as "Debris Flow"
# "Light Snow" is categorized as "Winter Weather" and so on..

# select only the starting words for match up of the official Storm Data Event Table
# if two event appears in the same time, assume the one appears first is the main event
# this avoid descriptive words appears several times in random place can lead to incorrect grouping 
# for example wind in High Wind / Strong Wind / Marine High Wind / Thunderstorm Wind

# some incorrect spelling are observed and need for correction
# however we need consider precision searching so it should not group more words
# for example, "thun.*" is in used for correction of THUNDEERSTORM WINDS / THUNERSTORM WINDS but not for TUNDERSTORM WIND / THUDERSTORM WINDS
# keywords used in the beginning of event is prior used than keywords ending the event 
# because there ware more words begining with "thu" and only two cases to ignore if use "thun"

# storm %>% count(EVTYPE) %>% arrange(EVTYPE) %>% as.data.frame()
# storm %>% filter(as_date(BGN_DATE, format = "%m/%d/%Y") >= "1999-01-01") %>% mutate(EVTitle = str_to_title(EVTYPE)) %>% count(EVTitle) %>% arrange(EVTitle) %>% as.data.frame()

storm_event <- storm %>%
filter(!str_detect(EVTYPE, "SUMMARY.*") & !str_detect(EVTYPE, "Summary.*")) %>%
# Build new column name it Event for data cleansing while orignal column EVTYPE is kept for reference
mutate(Event = EVTYPE) %>%
# Remove measures description like speed and height to align the events
mutate(Event = str_replace_all(Event, "G[0-9].*", "")) %>%
mutate(Event = str_replace_all(Event, "F[0-9].*", "")) %>%
mutate(Event = str_replace_all(Event, "[0-9].*", "")) %>%
mutate(Event = str_replace_all(Event, "\\(.*", "")) %>%
mutate(Event = str_to_lower(Event)) %>%
# Collect events starting with specific words
mutate(Event = str_replace_all(Event, regex("^avalan.*"), "Avalanche")) %>%
mutate(Event = str_replace_all(Event, regex("^blizzard.*"), "Blizzard")) %>%
mutate(Event = str_replace_all(Event, regex("^coastal.*"), "Coastal Flood")) %>%
mutate(Event = str_replace_all(Event, regex("^cold.*"), "Cold/Wind Chill")) %>%
mutate(Event = str_replace_all(Event, regex("^record.*?cold.*"), "Cold/Wind Chill")) %>%
mutate(Event = str_replace_all(Event, regex("^land.*"), "Debris Flow")) %>%
mutate(Event = str_replace_all(Event, regex("^mudslide$"), "Debris Flow")) %>%
mutate(Event = str_replace_all(Event, regex("^drought.*"), "Drought")) %>%
mutate(Event = str_replace_all(Event, regex("^dry.*"), "Drought")) %>%
mutate(Event = str_replace_all(Event, regex("^dust d.*"), "Dust Devil")) %>%
mutate(Event = str_replace_all(Event, regex("^extreme.*?cold.*"), "Extreme Cold/Wind Chill")) %>%
mutate(Event = str_replace_all(Event, regex("^ext.*?cold/windchill.*"), "Extreme Cold/Wind Chill")) %>%
mutate(Event = str_replace_all(Event, regex("^extreme wind.*"), "Extreme Cold/Wind Chill")) %>%
mutate(Event = str_replace_all(Event, regex("^flash flood.*"), "Flash Flood")) %>%
mutate(Event = str_replace_all(Event, regex("^flood.*"), "Flood")) %>%
mutate(Event = str_replace_all(Event, regex("^river flood$"), "Flood")) %>%
mutate(Event = str_replace_all(Event, regex("^urban/small stream flood$"), "Flood")) %>%
mutate(Event = str_replace_all(Event, regex("^freez.*"), "Frost/Freeze")) %>%
mutate(Event = str_replace_all(Event, regex("^frost.*"), "Frost/Freeze")) %>%
mutate(Event = str_replace_all(Event, regex("^fog.*"), "Freezing Fog")) %>%
mutate(Event = str_replace_all(Event, regex("^funnel.*"), "Funnel Cloud")) %>%
mutate(Event = str_replace_all(Event, regex("^hail.*"), "Hail")) %>%
mutate(Event = str_replace_all(Event, regex("^small hail$"), "Hail")) %>%
mutate(Event = str_replace_all(Event, regex("^extreme heat.*"), "Heat")) %>%
mutate(Event = str_replace_all(Event, regex("^record.*?heat.*"), "Heat")) %>%
mutate(Event = str_replace_all(Event, regex("^heat.*"), "Heat")) %>%
mutate(Event = str_replace_all(Event, regex("^heavy rain.*"), "Heavy Rain")) %>%
mutate(Event = str_replace_all(Event, regex("^heavy.*?snow.*"), "Heavy Snow")) %>%
mutate(Event = str_replace_all(Event, regex("^excessive snow$"), "Heavy Snow")) %>%
mutate(Event = str_replace_all(Event, regex("^high surf.*"), "High Surf")) %>%
mutate(Event = str_replace_all(Event, regex("^high wind.*"), "High Wind")) %>%
mutate(Event = str_replace_all(Event, regex("^wind.*"), "High Wind")) %>%
mutate(Event = str_replace_all(Event, regex("^hurricane.*"), "Hurricane (Typhoon)")) %>%
mutate(Event = str_replace_all(Event, regex("^typhoon.*"), "Hurricane (Typhoon)")) %>%
mutate(Event = str_replace_all(Event, regex("^ice.*"), "Ice Storm")) %>%
mutate(Event = str_replace_all(Event, regex("^lake.*?effect snow$"), "Lake-Effect Snow")) %>%
mutate(Event = str_replace_all(Event, regex("^lightning.*"), "Lightning")) %>%
mutate(Event = str_replace_all(Event, regex("^marine tstm.*"), "Marine Thunderstorm Wind")) %>%
mutate(Event = str_replace_all(Event, regex("^rip current.*"), "Rip Current")) %>%
mutate(Event = str_replace_all(Event, regex("^sleet.*"), "Sleet")) %>%
mutate(Event = str_replace_all(Event, regex("^storm surge.*"), "Storm Surge/Tide")) %>%
mutate(Event = str_replace_all(Event, regex("^strong high wind$"), "Strong Wind")) %>%
mutate(Event = str_replace_all(Event, regex("^strong wind.*"), "Strong Wind")) %>%
mutate(Event = str_replace_all(Event, regex("^thun.*"), "Thunderstorm Wind")) %>%
mutate(Event = str_replace_all(Event, regex("^tstm.*"), "Thunderstorm Wind")) %>%
mutate(Event = str_replace_all(Event, regex("^severe thunderstorms$"), "Thunderstorm Wind")) %>%
mutate(Event = str_replace_all(Event, regex("^torn.*"), "Tornado")) %>%
mutate(Event = str_replace_all(Event, regex("^tropical storm.*"), "Tropical Storm")) %>%
mutate(Event = str_replace_all(Event, regex("^volcanic.*"), "Volcanic Ash")) %>%
mutate(Event = str_replace_all(Event, regex("^water.*"), "Waterspout")) %>%
mutate(Event = str_replace_all(Event, regex("^wild.*?fire.*"), "Wildfire")) %>%
mutate(Event = str_replace_all(Event, regex("^winter s.*"), "Winter Storm")) %>%
mutate(Event = str_replace_all(Event, regex("^winter w.*"), "Winter Weather")) %>%
mutate(Event = str_replace_all(Event, regex("^snow.*"), "Winter Weather")) %>%
mutate(Event = str_replace_all(Event, regex("^light snow$"), "Winter Weather")) %>%
mutate(Event = str_replace_all(Event, regex("^wint.*?mix"), "Winter Weather")) %>%
# Collect events endding with specific words
mutate(Event = str_replace_all(Event, regex(".*drought$"), "Drought")) %>%
mutate(Event = str_replace_all(Event, regex(".*dry$"), "Drought")) %>%
mutate(Event = str_replace_all(Event, regex(".*flooding.*"), "Flood")) %>%
mutate(Event = str_replace_all(Event, regex(".*fld.*"), "Flood")) %>%
mutate(Event = str_replace_all(Event, regex(".*high surf$"), "High Surf")) %>%
mutate(Event = str_replace_all(Event, regex(".*thunderstorm$"), "Thunderstorm Wind")) %>%
mutate(Event = str_replace_all(Event, regex(".*winter storm$"), "Winter Storm")) %>%
mutate(Event = str_replace_all(Event, regex(".*winter weather$"), "Winter Weather")) %>%
mutate(Event = str_to_title(Event)) %>%
as.data.frame()


# 977 EVTYPE is cleaned to 316 Events and most 
storm_event %>% count(Event, sort = TRUE) %>% tibble()

# Merge storm data with event table
df <- merge(evnt_tbl, storm_event)

# All 48 event shows up
df %>% count(Event, sort = TRUE)

unique(df$CROPDMGEXP)
unique(df$PROPDMGEXP)

df <- df %>%
mutate(BgnDate = as_date(BGN_DATE, format = "%m/%d/%Y")) %>%
mutate(EndDate = as_date(END_DATE, format = "%m/%d/%Y")) %>%
mutate(BgnYear = year(BgnDate)) %>%
mutate(EndYear = year(EndDate)) %>%
mutate(PropDmgAmt =
    case_when(PROPDMGEXP %in% c("H", "h") ~ PROPDMG * 10^2,
            PROPDMGEXP %in% c("K", "k") ~ PROPDMG * 10^3,
            PROPDMGEXP %in% c("M", "m") ~ PROPDMG * 10^6,
            PROPDMGEXP %in% c("B", "b") ~ PROPDMG * 10^9,
            TRUE ~ PROPDMG)
            ) %>%
mutate(CropDmgAmt =
    case_when(CROPDMGEXP %in% c("H", "h") ~ CROPDMG * 10^2,
            CROPDMGEXP %in% c("K", "k") ~ CROPDMG * 10^3,
            CROPDMGEXP %in% c("M", "m") ~ CROPDMG * 10^6,
            CROPDMGEXP %in% c("B", "b") ~ CROPDMG * 10^9,
            TRUE ~ CROPDMG)
            ) %>%
mutate(TotalDmgAmt = PropDmgAmt + CropDmgAmt)


#summary(df)
#filter(df, PROPDMGEXP == "5") %>% top_n(5)
str(df)


## Across the United States, which types of events are most harmful to population health?

df %>% count(STATE, sort = TRUE) %>% tibble()

p1 <- df %>%
    group_by(Event) %>%
    summarise(
            Fatalities.Sum = sum(FATALITIES, na.rm = TRUE),
            Injuries.Sum = sum(INJURIES, na.rm = TRUE)
    ) %>%
    top_n(10) %>%
    melt(id = "Event")
    
ggplot(data = p1, aes(x = reorder(Event, value), y = value, fill = variable)) +
geom_bar(position = "dodge", stat = "identity") + coord_flip() +
theme_minimal()

p2s <- df %>%
    group_by(Designator, Event) %>%
    summarise(
            Fatalities.Sum = sum(FATALITIES, na.rm = TRUE),
            Injuries.Sum = sum(INJURIES, na.rm = TRUE)
    ) %>%
    top_n(10) %>%
    melt(id = c("Designator", "Event"))

p2 <- treemap(p2s,
            index = c("Designator", "Event", "variable"),
            vSize = "value",
            type = "index",
            palette = "Set2",
            bg.labels = c("white"),
            align.labels = list(
              c("center", "center"),
              c("right", "bottom")
            )
          )

d3tree2(p2, rootname = "United States 1950 - 2011 number of injuries and fatalities by event desinator (C - County | Z - Zone | M - Marine)")


## Across the United States, which types of events have the greatest economic consequences?

p3 <- df %>%
    group_by(Event) %>%
    summarise(
            PropDmgAmt.Sum = sum(PropDmgAmt, na.rm = TRUE),
            CropDmgAmt.Sum = sum(CropDmgAmt, na.rm = TRUE)
    ) %>%
    top_n(10) %>%
    melt(id = "Event")
    
ggplot(data = p3, aes(x = reorder(Event, value), y = value, fill = variable)) +
geom_bar(position = "dodge", stat = "identity") + coord_flip() +
theme_minimal()

p4s <- df %>%
    group_by(Designator, Event) %>%
    summarise(
            PropDmgAmt.Sum = sum(PropDmgAmt, na.rm = TRUE),
            CropDmgAmt.Sum = sum(CropDmgAmt, na.rm = TRUE)
    ) %>%
    top_n(10) %>%
    melt(id = c("Designator", "Event"))

p4 <- treemap(p4s,
            index = c("Designator", "Event", "variable"),
            vSize = "value",
            type = "index",
            palette = "Set2",
            bg.labels = c("white"),
            align.labels = list(
              c("center", "center"),
              c("right", "bottom")
            )
          )

d3tree2(p4, rootname = "United States 1950 - 2011 property and crop damage by event desinator (C - County | Z - Zone | M - Marine)")

## Plot total damage to map across the United States

lonlat <- mutate_geocode(state_tbl, StateName)

p5s <- df %>%
    group_by(STATE, BgnYear) %>%
    summarise(
            TotalDmgAmt.Sum = sum(TotalDmgAmt, na.rm = TRUE)
    ) %>%
    top_n(10)

p5ll <- merge(p5s, lonlat)

str(p5ll)

p5ll %>% arrange(BgnYear)
df %>% filter(BgnYear == 2006 & STATE == "CA") %>% slice_max(TotalDmgAmt)

p5 <- ggmap(get_map(location = "USA", zoom = 4), darken = .3, 
base_layer = ggplot(data = p5ll, aes(x = lon, y = lat, frame = BgnYear, ids = STATE))) +
geom_point(data = p5ll, aes(color = TotalDmgAmt.Sum, size = TotalDmgAmt.Sum, alpha = .7)) +
scale_size(range = c(4, 12)) +
scale_color_viridis_c()

ggplotly(p5)


