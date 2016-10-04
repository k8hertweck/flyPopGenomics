###LD decay

#run LDplot2R.R and LDplot2L.R first

#merge chromosomes 1 and 2
ACO2<-rbind(ACO2L, ACO2R)
CO2<-rbind(CO2L, CO2R)
nCO2<-rbind(nCO2L, nCO2R)
AO2<-rbind(AO2L, AO2R)
BO2<-rbind(BO2L, BO2R)
BX2<-rbind(BX2L, BX2R)

#average MLE and R2 for each distance and replot
ACO2MLEmean <- aggregate(MLE ~ distance, data=ACO2, mean)
CO2MLEmean <- aggregate(MLE ~ distance, data=CO2, mean)
nCO2MLEmean <- aggregate(MLE ~ distance, data=nCO2, mean)
AO2MLEmean <- aggregate(MLE ~ distance, data=AO2, mean)
BO2MLEmean <- aggregate(MLE ~ distance, data=BO2, mean)
BX2MLEmean <- aggregate(MLE ~ distance, data=BX2, mean)

#plot average points
#CO vs ACO

pdf(file="figures/LD2.pdf")

#plot in one figure
par(mfrow=c(3,1))

plot(subset(CO2MLEmean, distance > 10), pch=19, 
     main="LD(MLE) for CO(black) and ACO(red) on 2", 
     ylim=c(0.2,0.8))
points(subset(ACO2MLEmean, distance > 10), col="red")

#nCO vs AO
plot(subset(nCO2MLEmean, distance > 10), pch=19, 
     main="LD(MLE) for nCO(black) and AO(red) on 2",
     ylim=c(0.2,0.8))
points(subset(AO2MLEmean, distance > 10), col="red")

#NCO vs CO
plot(subset(nCO2MLEmean, distance > 10), pch=19, 
     main="LD(MLE) for nCO(black) and CO(red) on 2",
     ylim=c(0.2,0.8))
points(subset(CO2MLEmean, distance > 10), col="red")

#ACO vs AO
plot(subset(ACO2MLEmean, distance > 10), pch=19, 
     main="LD(MLE) for ACO(black) and AO(red) on 2",
     ylim=c(0.2,0.8))
points(subset(AO2MLEmean, distance > 10), col="red")

#BO vs BX
plot(subset(BO2MLEmean, distance > 10), pch=19, 
     main="LD(MLE) for BO(black) and B(red) on 2",
     ylim=c(0.2,0.8))
points(subset(BX2MLEmean, distance > 10), col="red")

dev.off()

write.csv(ACO2MLEmean, file="share/ACO2MLEmean.csv", row.names=FALSE, quote=TRUE)
write.csv(CO2MLEmean, file="share/CO2MLEmean.csv", row.names=FALSE, quote=TRUE)
write.csv(nCO2MLEmean, file="share/nCO2MLEmean.csv", row.names=FALSE, quote=TRUE)
write.csv(AO2MLEmean, file="share/AO2MLEmean.csv", row.names=FALSE, quote=TRUE)
write.csv(BO2MLEmean, file="share/BO2MLEmean.csv", row.names=FALSE, quote=TRUE)
write.csv(BX2MLEmean, file="share/BX2MLEmean.csv", row.names=FALSE, quote=TRUE)