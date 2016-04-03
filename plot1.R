## Script Name: plot1.R
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from 
#all sources for each of the years 1999, 2002, 2005, and 2008.

##  Set working directory
setwd("E:\\RStudio\\Coursera\\Exploratory Data  Analysis\\Week4")

## Step 1: read in the data
if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

tot.PM25.by.year <- tapply(NEI$Emissions, NEI$year, sum)

###Step 2: prepare to plot to png
png("plot1.png", width=640, height=480)
plot(names(tot.PM25.by.year), tot.PM25.by.year, type="o", xlab = "Year", ylab = expression("Total "~ PM[2.5] ~ " Emissions(tons)"), 
     main = expression("Total " ~ PM[2.5] ~ " Emissions in the United States"), col="darkgreen", pch=18, lty = 5)
dev.off()
