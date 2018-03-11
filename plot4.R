#################################################################################
# Library Load Section.
# Library being used : lubridate
#################################################################################
require(lubridate)


#################################################################################
# Data Reading Section.
# This section is to read raw data of household power consumption.
# Data will be used is only from the dates 2007-02-01 and 2007-02-02.
#################################################################################

#Read the data from text file then subset only from the dates 
#2007-02-01 and 2007-02-02
dataset <- read.table(file = "household_power_consumption.txt", 
                      sep = ";", 
                      header = TRUE, 
                      na.strings = "?" , 
                      stringsAsFactors = FALSE)

dataset <- subset(dataset, 
                  dataset$Date == "1/2/2007" | dataset$Date == "2/2/2007")


#Create a new DateTime column from combination of Date & Time column 
#in dataset
datetime <- strptime(paste(dataset$Date,dataset$Time), "%d/%m/%Y %H:%M:%S")
dataset <- cbind(datetime, dataset)
names(dataset)[1] <- "DateTime"

#Parse Date and Time string into correspondingg Data and Time class
dataset$Date <- dmy(dataset$Date)
dataset$Time <- hms(dataset$Time)

#Remove unnecesary temporary variable
rm(datetime)


#################################################################################
# Data Plotting Section.
# This section is to create a data plot and send the output to PNG file device
#################################################################################
png(file = "plot4.png")

#Set 2x2 panel for plotting area
par(mfrow = c(2,2))

######First Plot#################################################################
with(dataset, 
     plot(DateTime, 
          Global_active_power, 
          type = "l", 
          xlab = "",
          ylab = "Global Active Power"
     )
)
######End of First Plot##########################################################


######Second Plot################################################################
with(dataset, 
     plot(DateTime, 
          Voltage, 
          type = "l", 
          xlab = "datetime",
          ylab = "Voltage"
     )
)
######End of Second Plot#########################################################


######Third Plot#################################################################
#Plot lines for Sub_metering_1
with(dataset,
     plot(DateTime,
          Sub_metering_1,
          type = "l", 
          xlab = "", 
          ylab = "Energy Sub Metering"))

#Plot lines for Sub_metering_2
with(dataset,
     lines(
       DateTime,
       Sub_metering_2,
       type = "l", 
       col="red"))

#Plot lines for Sub_metering_3
with(dataset,
     lines(
       DateTime,
       Sub_metering_3,
       type = "l", 
       col="blue"))

#Create a legend fot the line graph
legend("topright", 
       lty = 1, 
       bty = "n",
       col = c("black","red","blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3") )

######End of Third Plot##########################################################


######Fourth Plot################################################################
with(dataset, 
     plot(DateTime, 
          Global_reactive_power, 
          type = "l", 
          xlab = "datetime",
          ylab = "Global Reactive Power"
     )
)
######End of Fourth Plot#########################################################

dev.off()




