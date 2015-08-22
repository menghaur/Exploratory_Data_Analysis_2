# Question 5
# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

setwd("C:/Apps/DataScience/ass")

# This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}

if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

# This, of course, assumes that the ggplot2 package has already been installed
library(ggplot2)

# 24510 is Baltimore, see plot2.R
# Searching for ON-ROAD type in NEI
# Searching for 'motor' in SCC only gave a subset (non-cars)
subsetNEI <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]

aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEI, sum)

png("plot5.png", width=840, height=480)
g <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("Year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ylim(0,400) +
  ggtitle('Total Emissions from motor vehicle (type = ON-ROAD) 
        in Baltimore City, Maryland (fips = "24510") from 1999 to 2008')
print(g)
dev.off()