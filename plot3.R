# Question 3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
# Which have seen increases in emissions from 1999-2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

setwd("C:/Apps/DataScience/ass")

# This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}

# This, of course, assumes that the ggplot2 package has already been installed
library('ggplot2')
  
baltimore <- NEI[NEI$fips=='24510',]
  
# Summarize the total emissions for each source and convert to a data frame
summary <-tapply(baltimore$Emissions, list(baltimore$type, baltimore$year), sum)
summary <- as.data.frame(as.table(summary))
  
# Create the basic plot
g <- ggplot(summary, aes(Var2, Freq)) + geom_bar(stat='identity') + 
  facet_wrap(~Var1) 
  
# Add some descriptive features
g <- g + ggtitle(expression('PM'[2.5]*' Emissions from various sources in Baltimore, MD (1999-2008)'))
g <- g + ylab(expression('Tons of PM'[2.5]))
g <- g + xlab('Years')
  
# Plot
png('plot3.png')
print(g)
dev.off()