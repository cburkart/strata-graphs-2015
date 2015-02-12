library(quantmod)
library(googleVis)

getSymbols('UNRATE', src='FRED')
getSymbols('JTSJOR', src='FRED')
getSymbols('CLF16OV', src='FRED')


# Recession dates: 2007-12 to 2009-06

data2004 <- cbind(UNRATE, JTSJOR, CLF16OV)['2004-12-01::2014-12']

rec.start <- which(index(data2004)=='2007-12-01')
rec.end   <- which(index(data2004)=='2009-06-01')

recession <- c(rep(1:rec.start,'NoRecession'),)
