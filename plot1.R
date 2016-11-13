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

# Reset base plot system
default <- par()
par(default)

#############################################

yearlyTotal <- aggregate(Emissions ~ year, NEI, sum)


par()
options(scipen=999) # removes scientific notation from the axis
png("plot1.png", width = 800, height = 800)
with(yearlyTotal,barplot(Emissions, 
                         names.arg=year,
                         col="springgreen4",
                         main=expression("PM"[2.5]*" Total US emissions from 1999 to 2008"), 
                         xlab="Years", 
                         ylab=expression("total PM"[2.5]*" emission in Tons"), 
                         cex.axis = 1, 
                         yaxt="n"))
# reduces font size to show large value, and adds a thousand separator for Y axis
axis(side=2, at=axTicks(2), 
     labels=formatC(axTicks(2), format="d", big.mark=','), cex.axis=0.9)
dev.off()
message("Plot 1 completed")