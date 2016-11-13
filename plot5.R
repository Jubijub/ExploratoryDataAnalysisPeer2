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
motorVehicles <- subset(NEI, fips == "24510" & type == "ON-ROAD")

yearlyTotal <- aggregate(Emissions ~ year, motorVehicles, sum)

#I used png + dev.off() method instead of ggsave as it's easier to specify pixel size of the output
png("./plot5.png", width = 800, height = 800)
options(scipen=999) # removes scientific notation from the axis
g <- ggplot(yearlyTotal, aes(year, Emissions)) +
geom_bar(stat="identity", fill="orange1") +
geom_text(aes(label=round(Emissions,0), size=0.5, hjust=0.5, vjust="top")) +
theme(legend.position="none") +
xlab("Year") +
ylab(expression('Total PM'[2.5]*" Vehicle-related Emissions in Tons")) +
ggtitle(expression("PM"[2.5]*" Total emissions from 1999 to 2008 in the US from vehicle related sources "))
print(g)
dev.off()

message("Plot 5 completed")