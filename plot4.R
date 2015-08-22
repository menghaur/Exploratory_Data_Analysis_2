# Question 4
# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

setwd("C:/Apps/DataScience/ass")

# This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}

if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

# Get all the SCC codes that contain some combination of the words 'coal' and 'comb' (for 'combustion').
# It was determined, through trial and error, that the Short.Name, EI.Sector, and SCC.Level.Four columns
# meet the specified regex criteria.
regex <- '([Cc]oal.*[Cc]omb)|([Cc]omb.*[Cc]oal)'
relevant <- grepl(regex, SCC$Short.Name) | grepl(regex, SCC$EI.Sector) | grepl(regex, SCC$SCC.Level.Four)
sccCodes <- SCC[relevant, 'SCC']

# This inquiry concerns coal-fired emissions from across the United States for the four years for which data has been provided.
coalCombustion <- NEI[NEI$SCC %in% sccCodes, ]
coalEmissions <- tapply(coalCombustion$Emissions, coalCombustion$year, sum)

# Plot
png('plot4.png')
barplot(coalEmissions/1000, main=expression('Total coal-combustion emissions of PM'[2.5]*' in the US (1999 to 2008)'),
        xlab='Years', ylab=expression('Kilotons of PM'[2.5]), ylim=c(0,600))
dev.off()