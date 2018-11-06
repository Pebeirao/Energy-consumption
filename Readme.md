# Energy Consumption analyse

## The source of the data 
The data was created by **Georges Hebrail (georges.hebrail '@' edf.fr), Senior Researcher, EDF R&D, Clamart, France 
Alice Berard, TELECOM ParisTech Master of Engineering Internship at EDF R&D, Clamart, France**.   

Acessable on http://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption.



## description of the data

47 months of energy consumption by the minute with more than 2 million inputs of a house near Paris in France.
The period is from 2006 to 2011 and has measured the:
1.date: Date in format dd/mm/yyyy 
2.time: time in format hh:mm:ss 
3.global_active_power: household global minute-averaged active power (in kilowatt) 
4.global_reactive_power: household global minute-averaged reactive power (in kilowatt) 
5.voltage: minute-averaged voltage (in volt) 
6.global_intensity: household global minute-averaged current intensity (in ampere) 
7.sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered). 
8.sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing machine, a tumble-drier, a refrigerator and a light. 
9.sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water heater and an air-conditioner.


## objectives

Find behaviours and patterns in the consumption, develop a time series to predict the future of consumption.
Find insights about the data and understand season pattern 

## formatting of the data 
The dataset contains some missing values in the measurements (nearly 1,25% of the rows). All calendar timestamps are present in the dataset but for some timestamps, the measurement values are missing: a missing value is represented by the absence of value between two consecutive semi-colon attribute separators. For instance, the dataset shows missing values on April 28, 2007.
It is not a relevant amount of data but to best fit the code I took the information from the same minute in the week before and used in the place.

Formatting the time to a Time series and be careful with add a timezone, in the code I did not use but the function anytime solves this problem too without the need of extra information.

After I created different Variables for the days, week, month years and etc to better understand the consume in the time.

The active power is not the one used to charge the clients and I could not use to compare a price, because of that I create a variable Apparent power that has the consumption charged in France, this variable is the 
sqrt((Global_active_power^2) +(Global_reactive_power^2)).

Another metric that I felt that was missing from the data was the general consumption:
 (global_active_power * 1000/60 - sub_metering_1 - sub_metering_2 - sub_metering_3) represents the active energy consumed every minute (in watt-hour) in the household by electrical equipment not measured in sub-meterings 1, 2 and 3.

On European Dataset there is the median price of the watt of energy by the hour of France I add this data to the dataset to make a comparison about the prices and the consumption.


## visualization
plot
plot
plot
plot
plot
## insights

Weather Pattern, 
Change in Pattern
Equilibrium
Warm and AC