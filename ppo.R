library(quantmod)

getSymbols('UNEMPLOY', src='FRED')
getSymbols('JTSJOL', src='FRED')

ppo <- UNEMPLOY/JTSJOL

plot(ppo['2004-12::'], ylim=c(0,7), main="Unemployed persons per job opening")
lines(ppo['2004-12::'], lwd=3, col='darkblue')
abline(h=as.numeric(last(ppo)), lty=2)
