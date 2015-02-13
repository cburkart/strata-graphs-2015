library(quantmod)
library(googleVis)

getSymbols('UNRATE', src='FRED')
getSymbols('JTSJOR', src='FRED')
getSymbols('CLF16OV', src='FRED')


# Recession dates: 2007-12 to 2009-06

data2004 <- cbind(UNRATE, JTSJOR, CLF16OV)['2004-12-01::2014-12']

rec.start <- which(index(data2004)=='2007-12-01')
rec.end   <- which(index(data2004)=='2009-06-01')

recession <- xts(c(rep(0,rec.start-1), rep(1,(rec.end-rec.start+1)), rep(0,nrow(data2004)-rec.end)), order.by=index(data2004))
workdat.xts <- cbind(data2004,recession)
names(workdat.xts) <- c('Unemployment','JobOpenRate','LaborForce','Recession')

workdat.df <- data.frame(index(workdat.xts), workdat.xts$Unemployment, workdat.xts$JobOpenRate, workdat.xts$LaborForce, workdat.xts$Recession, rep(0,nrow(workdat.xts)))
names(workdat.df) <- c('Date','Unemployment','JobOpenRate','LaborForce','Recession','Null')

# Something not working quite right with motion charts
#M <- gvisMotionChart(workdat.df, idvar='Null', timevar='Date')

plotdat.df <- data.frame(workdat.df$Unemployment, workdat.df$JobOpenRate, substr(index(workdat.xts),1,7))
names(plotdat.df) <- c('Unemployment','JobOpenRate','Date', )
plot(plotdat.df$Unemployment, plotdat.df$JobOpenRate, col='white', xlab="Unemployment Rate",ylab="Job Openings Rate", xlim=c(4.5,10.6), ylim=c(1.5,3.6))
lines(plotdat.df$Unemployment[1:rec.start], plotdat.df$JobOpenRate[1:rec.start], col='darkgreen', lwd=2)
lines(plotdat.df$Unemployment[(rec.start):rec.end], plotdat.df$JobOpenRate[(rec.start):rec.end], col='red',lwd=2)
lines(plotdat.df$Unemployment[rec.end:nrow(plotdat.df)], plotdat.df$JobOpenRate[rec.end:nrow(plotdat.df)], col='darkgreen', lwd=2)
lines(plotdat.df$Unemployment[1:rec.start], plotdat.df$JobOpenRate[1:rec.start], col='darkgreen', lwd=2, typ='b')
lines(plotdat.df$Unemployment[(rec.start):rec.end], plotdat.df$JobOpenRate[(rec.start):rec.end], col='red', lwd=2, typ='b')
lines(plotdat.df$Unemployment[rec.end:nrow(plotdat.df)], plotdat.df$JobOpenRate[rec.end:nrow(plotdat.df)], col='darkgreen', lwd=2, typ='b')
label.df <- plotdat.df[c(37,49,61,121),]
textxy(label.df$Unemployment, label.df$JobOpenRate, label.df$Date, cex=.85)

