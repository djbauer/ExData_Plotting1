#plot4.R
#       Script created to partially satisfy completion of Coursera course 
#       "Exploratory Data Analysis", week 1 project.
#       Created by David J. Bauer, 2018-10-20

########## BEGIN COMMON CODE ###################################################

#NOTE: The repository will include four scripts, one for each plot. Each script 
#       will begin identically with Steps 0 - 3 below; the code for each 
#       individual plot will begin with Step 4.
#       

#STEP 0: Outside of R, forked Github repository located at 
#       https://github.com/rdpeng/ExData_Plotting1 and cloned to local machine.
#       Then set working directory to cloned folder and load the tidyverse 
#       and lubridate since some of the code uses aspects of these packages.

setwd("~/GitHub/ExData_Plotting1")
library(tidyverse)
library(lubridate)


#STEP 1: Download and extract the data set. This can take a while so I set it up 
#       to check for existing folders/files first since I"m repeatedly running 
#       the script during development to test the code. Also since there are 
#       four scripts using the same data; no need to recreate the wheel.

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("./data/exdata.zip")){download.file(fileUrl, destfile = "./data/exdata.zip")}
if(!file.exists("./data/household_power_consumption.txt")){unzip("./data/exdata.zip", exdir = "./data")}


#STEP 2: Read the data set into an object. The data are separated by a semicolon 
#       so make sure to specify that. This can be take a while so I set it up to 
#       check for an existing object first for reasons noted above. Make sure to 
#       identify NA values (coded as "?" in raw data).

if(!exists("alldata")){alldata <- read.delim("./data/household_power_consumption.txt", 
                                             header = TRUE, 
                                             sep = ";", 
                                             na.strings = "?", 
                                             stringsAsFactors = FALSE)}


#STEP 3: Select the data for further analysis. We only need data from 2007-02-01
#       and 2007-02-02.

#       3A. First convert the Date variable from character to date.
if(!is.Date(alldata$Date)){alldata$Date = dmy(alldata$Date)}

#       3B. Now extract just the data for the identified dates.
if(!exists("extracted")){extracted <- subset(alldata, alldata$Date =="2007-02-01" | alldata$Date == "2007-02-02")}


########## END COMMON CODE #####################################################

#STEP 4: Create a single image that combines four plots. The topleft plot is 
#       the same as plot2. The bottomleft plot is the same as plot3. The 
#       topright plot is Voltage over datetime. The bottomright plot is 
#       Global_reactive_power over datetime.

#       4A. First create a variable that combines date and time since both 
#       are required for the graphs.
extracted$datetime <- paste(extracted$Date, extracted$Time)
extracted$datetime <- as.POSIXct(extracted$datetime)

#       4B. Second set up the plot parameters to establish 2x2 grid.
par(mfcol = c(2,2))

#       4C. Add the first plot (from previous plot2 code).
plot(extracted$Global_active_power ~ extracted$datetime, ylab = "Global Active Power (kilowatts)", xlab = "", type = "l")

#       4D. Add the second plot (from previous plot3 code) but the legend has
#       a transparent background, no border, and smaller text.
plot(extracted$datetime, extracted$Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "l")
lines(extracted$datetime, extracted$Sub_metering_2, col = "red")
lines(extracted$datetime, extracted$Sub_metering_3, col = "blue")
legend("topright", legend = colnames(extracted[7:9]), lty=c(1,1,1), col=c("black","red","blue"), bg = NA, bty = "n", cex = 0.75)

#       4E. Create the third plot.
plot(extracted$Voltage ~ extracted$datetime, ylab = "Voltage", xlab = "datetime", type = "l")

#       4F. Create the fourth plot.
plot(extracted$Global_reactive_power ~ extracted$datetime, ylab = "Global_reactive_power", xlab = "datetime", type = "l")

#       Create a PNG copy.
dev.copy(png, 'plot4.png', 
         width = 480, 
         height = 480, 
         units = "px")
dev.off()
