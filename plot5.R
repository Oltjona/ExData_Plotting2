## Script Name: plot5.R
# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? 

library(ggplot2)
library(plyr)

##  Set working directory
setwd("E:\\RStudio\\Coursera\\Exploratory Data  Analysis\\Week4")

## Step 1: read the data
if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

##Step 1A: subset the emissions from motor vehicles 
#For purposes of this study, I have defined motor vehicles sources as highway vehicles.  
#Included categories are:

# - Mobile - On-road - Diesel Heavy Duty Vehicles
# - Mobile - On-road - Diesel Light Duty Vehicles
# - Mobile - On-road - Gasoline Heavy Duty Vehicles
# - Mobile - On-road - Gasoline Light Duty Vehicles

mv.grep1 <- unique(grep("Vehicles", SCC$EI.Sector, ignore.case = TRUE, value = TRUE)) 

mv.source <- SCC[SCC$EI.Sector %in% mv.grep1, ]["SCC"]


##Step 2B: subset the emissions from motor vehicles from
##NEI for Baltimore, MD.
emMV.ba <- NEI[NEI$SCC %in% mv.source$SCC & NEI$fips == "24510",]

aggregate.emMV.ba <- ddply(emMV.ba, .(year), function(x) sum(x$Emissions))
colnames(aggregate.emMV.ba)[2] <- "Emissions"   

png("plot5.png", width=640, height = 480)
g<-qplot(year, Emissions, data=aggregate.emMV.ba, geom="line") + ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year")) + xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
print(g)
dev.off()
