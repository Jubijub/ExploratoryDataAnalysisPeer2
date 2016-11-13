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

baltimore <- x <- NEI[NEI$fips == "24510",]
yearlyTotal <- aggregate(Emissions ~ year, baltimore, sum)



par()
options(scipen=999)
png("plot2.png", width = 800, height = 800)
with(yearlyTotal, plot(year, Emissions, xlim=c(1998, 2008), type="o", lwd=2, col="red", pch=19, main="PM2.5 Total emissions from 1999 to 2008 for Baltimore (FIPS 24510)", xlab="Years", ylab=expression('Total PM'[2.5]*" Emissions in Tons"), cex.axis = 1, xaxp=c(1999,2008,3), yaxt="n"))
axis(side=2, at=axTicks(2), 
     labels=formatC(axTicks(2), format="d", big.mark=','), cex.axis=1)
dev.off()
message("Plot 2 completed")