# ----------------------library used ---------------------------
library(readr)
library(imputeTS)
library(dplyr)
library(tidyr)
library(lubridate)
library(zoo)
library(ggplot2)






#-----------------------Data sets------------------------------- 
DFhousehold <- read.csv("~/Ubiqum/Eneryconsumition/household_power_consumption.txt",
                           sep=";",stringsAsFactors = FALSE, na.strings = c("?",""))

#----------------- removing NA By David library(imputeTS) ------------------------

DFhousehold$Global_active_power <- na.seasplit(ts
                                  (DFhousehold$Global_active_power,
                                    frequency = 10080),
                                    algorithm = "locf")
DFhousehold$Global_reactive_power <- na.seasplit(ts
                                    (DFhousehold$Global_reactive_power,
                                     frequency = 10080),
                                     algorithm = "locf")
DFhousehold$Voltage <- na.seasplit(ts
                       (DFhousehold$Voltage,
                        frequency = 10080),
                        algorithm = "locf")
DFhousehold$Global_intensity <- na.seasplit(ts
                                   (DFhousehold$Global_intensity,
                                     frequency = 10080),
                                   algorithm = "locf")
DFhousehold$Sub_metering_1 <- na.seasplit(ts
                                   (DFhousehold$Sub_metering_1,
                                     frequency = 10080),
                                   algorithm = "locf")
DFhousehold$Sub_metering_2 <- na.seasplit(ts
                                   (DFhousehold$Sub_metering_2,
                                     frequency = 10080),
                                   algorithm = "locf")
DFhousehold$Sub_metering_3 <- na.seasplit(ts
                                   (DFhousehold$Sub_metering_3,
                                     frequency = 10080),
                                   algorithm = "locf")

#------------------------------- Data formats-----------------

DFhousehold$DateTime <- as.POSIXct(paste(
  DFhousehold$Date, DFhousehold$Time),
  format="%d/%m/%Y %H:%M:%S", tz="UTC")

DFhousehold$Date <- as.Date(DFhousehold$Date, "%d/%m/%Y")

DFhousehold$Global_active_power<- as.numeric(DFhousehold$Global_active_power)
DFhousehold$Global_reactive_power<- as.numeric(DFhousehold$Global_reactive_power)
DFhousehold$Voltage<- as.numeric(DFhousehold$Voltage)
DFhousehold$Global_intensity<- as.numeric(DFhousehold$Global_intensity)
DFhousehold$Sub_metering_1<- as.numeric(DFhousehold$Sub_metering_1)
DFhousehold$Sub_metering_2<- as.numeric(DFhousehold$Sub_metering_2)
DFhousehold$Sub_metering_3<- as.numeric(DFhousehold$Sub_metering_3)

#------------------------------------date contructionslibrary(lubridate) --------------------

DFhousehold <- mutate(DFhousehold, Year= year(DFhousehold$DateTime))
DFhousehold <- mutate(DFhousehold, Month= month(DFhousehold$DateTime))
DFhousehold <- mutate(DFhousehold, Week= week(DFhousehold$DateTime))
DFhousehold <- mutate(DFhousehold, Quarter= quarter(DFhousehold$DateTime))
DFhousehold <- mutate(DFhousehold, Day = day(DFhousehold$DateTime))
DFhousehold <- mutate(DFhousehold, Weekday = weekdays.POSIXt(DFhousehold$DateTime))
#-----------------------------------Data manipulation---------------------------

DFhousehold$Global_Apparent_power <- sqrt(
  (DFhousehold$Global_active_power^2) + 
    (DFhousehold$Global_reactive_power^2))

# Sub parameter 4

DFhousehold$Sub_metering_General <- (DFhousehold$Global_active_power*1000/60 -
                                       DFhousehold$Sub_metering_1 -
                                       DFhousehold$Sub_metering_2 - 
                                       DFhousehold$Sub_metering_3)
#-------------------------add eletricity price---------------------
DFhousehold$PriceofEletricity<- ifelse(DFhousehold$Year == "2006",
                                       DFhousehold$PriceofEletricity <- 0.1194,
                                 ifelse(DFhousehold$Year == "2007",
                                        DFhousehold$PriceofEletricity <- 0.1211,
                                 ifelse(DFhousehold$Year == "2008",
                                        DFhousehold$PriceofEletricity <- 0.1213,
                                 ifelse(DFhousehold$Year == "2009",
                                        DFhousehold$PriceofEletricity <- 0.1206,
                                    ifelse(DFhousehold$Year == "2010",
                                           DFhousehold$PriceofEletricity <- 0.1283,
                                           print(0))))))

DFhousehold <- mutate(DFhousehold, EuroPERMinute = (DFhousehold$Global_active_power)
                      * (DFhousehold$PriceofEletricity)/60)
#------------------------ change col names ----------------------------

colnames(DFhousehold)[7] <- "Sub_Metering_Kitchen"
colnames(DFhousehold)[8] <- "Sub_Metering_Laundry"
colnames(DFhousehold)[9] <- "Sub_Metering_HotWater"

#----------------------------- mont year------------------------

DFhousehold <- mutate(DFhousehold, MonthYear= paste(DFhousehold$Month, DFhousehold$Year))
#------------------------------if the consomptuion was the same of 2007-------

DFhousehold <- mutate(DFhousehold, M2007Activepower = ((1.135251)* (DFhousehold$PriceofEletricity)/60))
