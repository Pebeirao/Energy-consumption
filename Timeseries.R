# forecast

library(TRR)

TSDF <- DFhousehold%>%
  group_by(Year,Month)%>%
    summarise(MeanConsumption = mean(Sub_Metering_HotWater))%>%
  filter(Year>2006)

TS <- ts(TSDF$MeanConsumption, f=12, start = c(2007,01))

plot.ts(TS)


TScomp <- decompose(TS, type= "additive")

plot(TScomp)

NSTS <- TS - TScomp$seasonal
plot(NSTS)

#get the values for times series

Time2 <- time(TS)

Time <- (c("2007-01","2007-02","2007-03","2007-04","2007-05","2007-06",
        "2007-07","2007-08","2007-09","2007-10","2007-11","2007-12",
        "2008-01","2008-02","2008-03","2008-04","2008-05","2008-06",
        "2008-07","2008-08","2008-09","2008-10","2008-11","2008-12",
        "2009-01","2009-02","2009-03","2009-04","2009-05","2009-06",
        "2009-07","2009-08","2009-09","2009-10","2009-11","2009-12",
        "2010-01","2010-02","2010-03","2010-04","2010-05","2010-06",
        "2010-07","2010-08","2010-09","2010-10","2010-11"))

dat <- cbind(Time, with(TScomp, data.frame(Observed=x, Trend=trend, Seasonal=seasonal, Random=random)))


# dat$Time<- as.POSIXct(dat$Time,format("%Y-%m"))
dat$Time <- Time2


autoplot(TScomp)+
# ggplot(gather(dat, component, value, -Time), aes(Time, value)) +
# facet_grid(component ~ ., scales="free_y") +
# geom_line() +
theme_bw() +
labs(y=expression(Active~Power), x="Year") +
ggtitle(expression(Total~Consumption)) +
theme(plot.title=element_text(hjust=0.7))





write.csv(TSDF,"MeanHotWaterbyDAyTS.csv")
