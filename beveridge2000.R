library(quantmod)
library(googleVis)

getSymbols('UNRATE', src='FRED')
getSymbols('JTSJOR', src='FRED')
getSymbols('CLF16OV', src='FRED')


# Recession dates: 2001-03 to 2001-11

data2000 <- cbind(UNRATE, JTSJOR, CLF16OV)['2000-12-01::2006-12']

rec.start <- which(index(data2000)=='2001-03-01')
rec.end   <- which(index(data2000)=='2001-11-01')

recession <- xts(c(rep(0,rec.start-1), rep(1,(rec.end-rec.start+1)), rep(0,nrow(data2000)-rec.end)), order.by=index(data2000))
workdat.xts <- cbind(data2000,recession)
names(workdat.xts) <- c('Unemployment','JobOpenRate','LaborForce','Recession')

workdat.df <- data.frame(index(workdat.xts), workdat.xts$Unemployment, workdat.xts$JobOpenRate, workdat.xts$LaborForce, workdat.xts$Recession, rep(0,nrow(workdat.xts)))
names(workdat.df) <- c('Date','Unemployment','JobOpenRate','LaborForce','Recession','Null')

# Something not working quite right with motion charts
#M <- gvisMotionChart(workdat.df, idvar='Null', timevar='Date')

plotdat.df <- data.frame(workdat.df$Unemployment, workdat.df$JobOpenRate, substr(index(workdat.xts),1,7))
names(plotdat.df) <- c('Unemployment','JobOpenRate','Date')
plot(plotdat.df$Unemployment, plotdat.df$JobOpenRate, col='white', xlab="Unemployment Rate",ylab="Job Openings Rate")
lines(plotdat.df$Unemployment[1:rec.start], plotdat.df$JobOpenRate[1:rec.start], col='darkgreen', lwd=2)
lines(plotdat.df$Unemployment[(rec.start):rec.end], plotdat.df$JobOpenRate[(rec.start):rec.end], col='red',lwd=2)
lines(plotdat.df$Unemployment[rec.end:nrow(plotdat.df)], plotdat.df$JobOpenRate[rec.end:nrow(plotdat.df)], col='darkgreen', lwd=2)
lines(plotdat.df$Unemployment[1:rec.start], plotdat.df$JobOpenRate[1:rec.start], col='darkgreen', lwd=2, typ='b')
lines(plotdat.df$Unemployment[(rec.start):rec.end], plotdat.df$JobOpenRate[(rec.start):rec.end], col='red', lwd=2, typ='b')
lines(plotdat.df$Unemployment[rec.end:nrow(plotdat.df)], plotdat.df$JobOpenRate[rec.end:nrow(plotdat.df)], col='darkgreen', lwd=2, typ='b')
label.df <- plotdat.df[c(1,4,12,73),]
textxy(label.df$Unemployment, label.df$JobOpenRate, label.df$Date, cex=.9)




