# Question 1
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

setwd("C:/Apps/DataScience/ass")

# This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}

# This inquiry concerns total emissions over the four years for which data has been provided.
# Find the total emissions for each of these years
aggregatedTotalByYear <- aggregate(Emissions ~ year, NEI, sum)


# Plot the totalEmissions data (barplot)
png('plot1.png')

barplot(height=aggregatedTotalByYear$Emissions/1000, names.arg=aggregatedTotalByYear$year, 
        xlab="Years", ylab=expression('Kilotons of PM'[2.5]*' emission'), ylim=c(0, 8000), 
        main=expression('Total PM'[2.5]*' emissions in the U.S from 1999 to 2008'))

dev.off()