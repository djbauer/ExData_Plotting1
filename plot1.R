#plot1.R
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

if(!exists("alldata")){alldata <- read.delim("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)}


#STEP 3: Select the data for further analysis. We only need data from 2007-02-01
#       and 2007-02-02.

#       3A. First, convert the Date variable from character to date. While we're
#       at it, might as well convert Time from character to hms. 
#       Use if! statements to avoid rerunning the conversion because doing so 
#       produces a warning.
if(!is.Date(alldata$Date)){alldata$Date = dmy(alldata$Date)}
if(!is.numeric(alldata$Time)){alldata$Time = hms(alldata$Time)}

#       3B. Now extract just the data for the identified dates.
if(!exists("extracted")){extracted <- subset(alldata, alldata$Date =="2007-02-01" | alldata$Date == "2007-02-02")}


########## END COMMON CODE #####################################################

#STEP 4: Create a bar graph plotting Global Active Power (kilowatts) on the x 
#       axis (range 0 - 6) and Frequency on the y axis (range 0 - 1200). This 
#       is a histogram with red bars, titled "Global Active Power", with x axis 
#       label of "Global Active Power (kilowatts)". The plot must be 480 x 480 
#       pixels and output a PNG file named plot1.png.
#
#       Note: The example plot has a transparent background and I can replicate 
#       that by adding par(bg=NA) as a line of code but then I can't view the 
#       plot properly in R Studio because I'm using a dark theme (and I can't 
#       seem to override the par() just for the screen device). So, I just let 
#       the default white background appear. Since the purpose of the exercise 
#       is to develop quick graphs for exploratory purposes (as opposed to 
#       preparing something for publication), I'm fine with this.

plot1 <- hist(extracted$Global_active_power, 
              col = "red", 
              main = "Global Active Power", 
              xlab = "Global Active Power (kilowatts)")

dev.copy(png, 'plot1.png', 
         width = 480, 
         height = 480, 
         units = "px")
dev.off()
