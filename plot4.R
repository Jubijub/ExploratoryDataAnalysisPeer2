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

# The selection below is imperfect, but it's not clear enough which sources are related to combustion or not just from the label
coalCodes <- grepl("coal", SCC$Short.Name, ignore.case=TRUE)
SCCCoal <- SCC[coalCodes,]
NEICoal <- merge(x=NEI, y=SCCCoal, by="SCC")

yearlyTotal <- aggregate(Emissions ~ year, NEICoal, sum)

#I used png + dev.off() method instead of ggsave as it's easier to specify pixel size of the output
png("./plot4.png", width = 800, height = 800)
options(scipen=999) # removes scientific notation from the axis
ggplot(yearlyTotal, aes(year, Emissions)) +
geom_line(size=2, colour="steelblue") +
xlab("Year") +
ylab(expression('Total PM'[2.5]*" Coal-related Emissions")) +
ggtitle("PM2.5 Total emissions from 1999 to 2008 in the US from coal related sources ")
dev.off()



message("Plot 4 completed")