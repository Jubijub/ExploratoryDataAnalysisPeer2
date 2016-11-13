# Exploratory Data Analysis Peer graded assignment #2 (week 4) by Jubijub

##Howto
You can use `plotAll.R` or source the files one by one.

1. source("plot1.R")
2. source("plot2.R")
3. source("plot3.R")
4. source("plot4.R")
5. source("plot5.R")
6. source("plot6.R")

Each script is independant, and will download the source data, unzip it and load it as required.

## Troubleshooting
### The zip file doesn't download
As those R scripts have been developped on a Windows machine, I had to remove the `method="curl"` from the download method. Should you test this script on a Mac or on Linux, you can simply download the zip file manually [here](https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip), put the zip in the same directory as the source files, and run the scripts as indicated above.

### require(ggplot2) fails
Install it using `install.packages("ggplot2")


## Assignment

This assignment uses data from [EPA National Inventory](http://www.epa.gov/ttn/chief/eiinformation.html).


* *Dataset*: [EPA PM2.5 data for 1999, 2002, 2005 and 2008](https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip) [29Mb]

## Explanation of the source data
### summarySCC_PM25.rds

* fips: A five-digit number (represented as a string) indicating the U.S. county
* SCC: The name of the source as indicated by a digit string (see source code classification table)
* Pollutant: A string indicating the pollutant
* Emissions: Amount of PM2.5 emitted, in tons
type: The type of source (point, non-point, on-road, or non-road)
* year: The year of emissions recorded

### Source_Classification_Code.rds
* mapping between the SCC digit string and the actual name, under different forms

## Results
![Plot1](https://github.com/Jubijub/ExploratoryDataAnalysisPeer2/blob/master/plot1.png "Plot1")
![Plot2](https://github.com/Jubijub/ExploratoryDataAnalysisPeer2/blob/master/plot2.png "Plot2")
![Plot3](https://github.com/Jubijub/ExploratoryDataAnalysisPeer2/blob/master/plot3.png "Plot3")
![Plot4](https://github.com/Jubijub/ExploratoryDataAnalysisPeer2/blob/master/plot4.png "Plot4")
![Plot5](https://github.com/Jubijub/ExploratoryDataAnalysisPeer2/blob/master/plot5.png "Plot5")
![Plot6](https://github.com/Jubijub/ExploratoryDataAnalysisPeer2/blob/master/plot6.png "Plot6")
