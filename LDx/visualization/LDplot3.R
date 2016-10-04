###LD decay

#run LDplot3R.R and LDplot3L.R first

#merge chromosomes 1 and 2
ACO3<-rbind(ACO3L, ACO3R)
CO3<-rbind(CO3L, CO3R)
nCO3<-rbind(nCO3L, nCO3R)
AO3<-rbind(AO3L, AO3R)
BO3<-rbind(BO3L, BO3R)
BX3<-rbind(BX3L, BX3R)

#average MLE and R2 for each distance and replot
ACO3MLEmean <- aggregate(MLE ~ distance, data=ACO3, mean)
CO3MLEmean <- aggregate(MLE ~ distance, data=CO3, mean)
nCO3MLEmean <- aggregate(MLE ~ distance, data=nCO3, mean)
AO3MLEmean <- aggregate(MLE ~ distance, data=AO3, mean)
BO3MLEmean <- aggregate(MLE ~ distance, data=BO3, mean)
BX3MLEmean <- aggregate(MLE ~ distance, data=BX3, mean)

#plot average points
#CO vs ACO

pdf(file="figures/LD3.pdf")

#plot in one figure
par(mfrow=c(3,1))

plot(subset(CO3MLEmean, distance > 10), pch=19, 
     main="LD(MLE) for CO(black) and ACO(red) on 3", 
     ylim=c(0.2,0.8))
points(subset(ACO3MLEmean, distance > 10), col="red")

#nCO vs AO
plot(subset(nCO3MLEmean, distance > 10), pch=19, 
     main="LD(MLE) for nCO(black) and AO(red) on 3",
     ylim=c(0.2,0.8))
points(subset(AO3MLEmean, distance > 10), col="red")

#NCO vs CO
plot(subset(nCO3MLEmean, distance > 10), pch=19, 
     main="LD(MLE) for nCO(black) and CO(red) on 3",
     ylim=c(0.2,0.8))
points(subset(CO3MLEmean, distance > 10), col="red")

#ACO vs AO
plot(subset(ACO3MLEmean, distance > 10), pch=19, 
     main="LD(MLE) for ACO(black) and AO(red) on 3",
     ylim=c(0.2,0.8))
points(subset(AO3MLEmean, distance > 10), col="red")

#BO vs BX
plot(subset(BO3MLEmean, distance > 10), pch=19, 
     main="LD(MLE) for BO(black) and B(red) on 3",
     ylim=c(0.2,0.8))
points(subset(BX3MLEmean, distance > 10), col="red")

dev.off()

write.csv(ACO3MLEmean, file="share/ACO3MLEmean.csv", row.names=FALSE, quote=TRUE)
write.csv(CO3MLEmean, file="share/CO3MLEmean.csv", row.names=FALSE, quote=TRUE)
write.csv(nCO3MLEmean, file="share/nCO3MLEmean.csv", row.names=FALSE, quote=TRUE)
write.csv(AO3MLEmean, file="share/AO3MLEmean.csv", row.names=FALSE, quote=TRUE)
write.csv(BO3MLEmean, file="share/BO3MLEmean.csv", row.names=FALSE, quote=TRUE)
write.csv(BX3MLEmean, file="share/BX3MLEmean.csv", row.names=FALSE, quote=TRUE)