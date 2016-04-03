## Script Name: plot4.R
# Across the United States, how have emissions from coal combustion-related sources changed 
#from 1999-2008?  

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

## Step 2: subset our data for only coal-combustion

#For purpose of this study I've decided to select data based on "Sector" and "Short.name" column 

#1. I've define that below sectors will be included:
# Fuel Comb - Comm/Instutional - Coal
# Fuel Comb - Electric Generation - Coal
# Fuel Comb - Industrial Boilers, ICEs - Coal

#2. Also to be more accurate I've included all codes that contain "Coal" and "Combustion" in
# Short.Name column

greps1 <- unique(grep("coal", SCC$EI.Sector, ignore.case=TRUE, value=TRUE))    
data1 <- subset(SCC, EI.Sector %in% greps1) 

## Step 3: Base on Second criteria of getting required data, 
#isolate instances of "coal" and "comb" in column Short.Name

data2 <- subset(SCC, grepl("Combustion", Short.Name) & grepl("Coal", Short.Name))

# union the two data sets data1 and data2
coalcomb.scc.codes <- union(data1$SCC, data2$SCC)

## Step 4: subset again for what we want
coal.comb <- subset(NEI, SCC %in% coalcomb.scc.codes)

##Step 5: get the PM25 values 
coalcomb.pm25year <- ddply(coal.comb, .(year, type), function(x) sum(x$Emissions))

#rename the col
colnames(coalcomb.pm25year)[3] <- "Emissions"


##Step 6: finally plot4.png prepare to plot to png
png("plot4.png", width=640, height = 480)
g<-  ggplot(coalcomb.pm25year, aes(x = factor(year), y = Emissions, fill =type)) + geom_bar(stat= "identity", width = .4) + xlab("year") +ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)")) + ggtitle(expression("Coal Combustion" ~ PM[2.5] ~ "Emissions by Source Type and Year"))
print(g)
dev.off()
