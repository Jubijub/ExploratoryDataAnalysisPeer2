##### COMMON BOILERPLATE FOR ALL FILES #####

## Downloading the source data
projectData <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
zipFile <- "./NEI_PM25.zip"

if (!file.exists(zipFile)){download.file(projectData, zipFile)}
message("Source File downloaded")
if(file.exists(zipFile)){unzip(zipfile=zipFile, exdir=".")}
message("ZIP content extracted")

## Load data files
files <- c("summarySCC_PM25.rds", "Source_Classification_Code.rds")
if (length(which(files %in% dir())) == 2) {
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
    message("Data files successfully loaded")
} else {
    stop("NEI / SCC source files not found")
}

#############################################
require(ggplot2)

# Relying on the fact NEI gives "ON-road" type, which matches SCC codes for "onroad"
mvBaltimore <- subset(NEI, fips == "24510" & type == "ON-ROAD")
mvLA <- subset(NEI, fips == "06037" & type == "ON-ROAD")

fullSet <- rbind(mvBaltimore, mvLA)
#Add pretty city name
fullSet$city[fullSet$fips=="24510"]<- "Baltimore City"
fullSet$city[fullSet$fips=="06037"]<- "Los Angeles County"



yearlyTotal <- aggregate(Emissions ~ year + city, fullSet, sum)

#I used png + dev.off() method instead of ggsave as it's easier to specify pixel size of the output
png("./plot6.png", width = 800, height = 800)
options(scipen=999) # removes scientific notation from the axis
ggplot(yearlyTotal, aes(year, Emissions)) +
geom_line(size=2, colour="orange1") +
facet_grid(. ~ city) + 
geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust="top")) +
theme(legend.position="none") +
xlab("Year") +
ylab(expression('Total PM'[2.5]*" Vehicle-related Emissions")) +
ggtitle("PM2.5 Total emissions from 1999 to 2008 in the US from Motor vehicle related sources ")
dev.off()

message("Plot 6 completed")