## Script Name: plot3.R
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999 2008 for Baltimore City? 
# Which have seen increases in emissions from 1999 2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)

##  Set working directory
setwd("E:\\RStudio\\Coursera\\Exploratory Data  Analysis\\Week4")

if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

# obtain the subsets to plot. Baltimore is 24510 
baltimore  <- NEI[NEI$fips=="24510", ]

baltTotByYearAndType <- aggregate(Emissions ~ year + type, baltimore, sum)

# prepare to plot to png
png("plot3.png", width=640, height=480)
g <- ggplot(baltTotByYearAndType, aes(year, Emissions, color = type))
g <- g + geom_line() +
  xlab("year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (in tons)")) + 
  ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Emmission by source, type and year")) 
print(g)
dev.off()