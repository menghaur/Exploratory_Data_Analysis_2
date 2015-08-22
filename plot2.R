# Question 2
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
#from 1999 to 2008? Use the base plotting system to make a plot answering this question.

setwd("C:/Apps/DataScience/ass")

# This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}

subsetNEI  <- NEI[NEI$fips=="24510", ]
  
aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEI, sum)
  
png('plot2.png')
barplot(height=aggregatedTotalByYear$Emissions, names.arg=aggregatedTotalByYear$year, 
        xlab="Years", ylab=expression('Total PM'[2.5]*' emission'), ylim=c(0,4000),
        main=expression('Total PM'[2.5]*' in the Baltimore City, Maryland (1999 to 2008)'))
dev.off()
  