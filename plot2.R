## Script Name: plot2.R
#Have total emissions from PM2.5 decreased in the Baltimore City, 
#Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot 
#answering this question.

##  Set working directory
setwd("E:\\RStudio\\Coursera\\Exploratory Data  Analysis\\Week4")

## Step 1: read in the data
if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}


## Step 2: obtain the subsets to plot
baltimore <- subset (NEI, fips == "24510")
baltimore.tot.PM25yr <- tapply(baltimore$Emissions, baltimore$year, sum)

## Step 3: plot prepare to plot to png
png("plot2.png", width=640, height=480)
plot(names(baltimore.tot.PM25yr), baltimore.tot.PM25yr, type = "o", xlab="Year", 
     ylab= expression("Total" ~ PM[2.5] ~ "Emissions (tons)"), 
     main=expression("Total for Baltimore City" ~ PM[2.5] ~ "Emissions by Year"), col = "purple",pch=18, lty = 5)
dev.off()     