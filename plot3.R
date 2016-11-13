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
baltimore <- x <- NEI[NEI$fips == "24510",]
aggregated <- aggregate(Emissions ~ year + type, baltimore, sum)


#I used png + dev.off() method instead of ggsave as it's easier to specify pixel size of the output
png("./plot3.png", width = 800, height = 800)
ggplot(aggregated, aes(year, Emissions, color=type)) +
geom_line(size=1) +
xlab("Year") +
ylab(expression('Total PM'[2.5]*" Emissions")) +
ggtitle("PM2.5 Total emissions from 1999 to 2008 for Baltimore (FIPS 24510) by type of source ")
dev.off()

message("Plot 3 completed")