## Script Name: plot6.R
## Compare emissions from motor vehicle sources in Baltimore City 
## with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?

## Libraries needed: 
library(plyr)
library(ggplot2)
library(grid)

##  Set working directory
setwd("E:\\RStudio\\Coursera\\Exploratory Data  Analysis\\Week4")
## Step 1: read the data
if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}


##Step 1: subset the emissions from motor vehicles 
mv.grep1 <- unique(grep("Vehicles", SCC$EI.Sector, ignore.case = TRUE, value = TRUE)) 
mv.source <- SCC[SCC$EI.Sector %in% mv.grep1, ]["SCC"]


## Step 2A: subset our data Baltimore City
emMV.ba <- NEI[NEI$SCC %in% mv.source$SCC & NEI$fips == "24510", ]
## Step 2B: subset our data Los Angeles County
emMV.LA <- NEI[NEI$SCC %in% mv.source$SCC & NEI$fips == "06037", ]

## Step 2C: bind the data created in steps 2A and 2B
emMV.comp <- rbind(emMV.ba, emMV.LA)

## Step 3: Find the emmissions due to motor vehicles in 
## Baltimore (city) and Los Angeles County
agg.emMV.comp.county <- aggregate (Emissions ~ fips * year, data =emMV.comp, FUN = sum ) 
agg.emMV.comp.county$county <- ifelse(agg.emMV.comp.county$fips == "06037", "Los Angeles", "Baltimore")

## Step 5: plotting to png
png("plot6.png", width=750)
g<-qplot(year, Emissions, data=agg.emMV.comp.county, geom="line", color=county) + ggtitle(expression("Motor Vehicle Emission Levels" ~ PM[2.5] ~ "  from 1999 to 2008 in Los Angeles County, CA and Baltimore, MD")) + xlab("Year") + ylab(expression("Levels of" ~ PM[2.5] ~ " Emissions"))
print(g)
dev.off()

