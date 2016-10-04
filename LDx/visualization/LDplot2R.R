###LD decay

#data import
LDxheader <- c("locationSNP1","locationSNP2","x_11","x_12","x_21","x_22","freqA","freqB","depthSNP1","depthSNP2","isectReadDepth","lowMLE","MLE","highMLE","directR2","A","a","B","b")

###2R
#combine population results into a single file
system('cat 2R/ACO*.flt.out > 2R/ACO2R.out')
system('cat 2R/CO*.flt.out > 2R/CO2R.out')
system('cat 2R/nCO*.flt.out > 2R/nCO2R.out')
system('cat 2R/AO*.flt.out > 2R/AO2R.out')
system('cat 2R/BO*.flt.out > 2R/BO2R.out')
system('cat 2R/BX*.flt.out > 2R/BX2R.out')

#read file
ACO2R <- read.delim(file = "2R/ACO2R.out", header = FALSE, col.names = LDxheader)
CO2R <- read.delim(file = "2R/CO2R.out", header = FALSE, col.names = LDxheader)
nCO2R <- read.delim(file = "2R/nCO2R.out", header = FALSE, col.names = LDxheader)
AO2R <- read.delim(file = "2R/AO2R.out", header = FALSE, col.names = LDxheader)
BO2R <- read.delim(file = "2R/BO2R.out", header = FALSE, col.names = LDxheader)
BX2R <- read.delim(file = "2R/BX2R.out", header = FALSE, col.names = LDxheader)

#add distance
ACO2R <- transform(ACO2R, distance = ACO2R$locationSNP2 - ACO2R$locationSNP1)
CO2R <- transform(CO2R, distance = CO2R$locationSNP2 - CO2R$locationSNP1)
nCO2R <- transform(nCO2R, distance = nCO2R$locationSNP2 - nCO2R$locationSNP1)
AO2R <- transform(AO2R, distance = AO2R$locationSNP2 - AO2R$locationSNP1)
BO2R <- transform(BO2R, distance = BO2R$locationSNP2 - BO2R$locationSNP1)
BX2R <- transform(BX2R, distance = BX2R$locationSNP2 - BX2R$locationSNP1)

#average MLE and R2 for each distance and replot
ACO2RMLEmean <- aggregate(MLE ~ distance, data=ACO2R, mean)
CO2RMLEmean <- aggregate(MLE ~ distance, data=CO2R, mean)
nCO2RMLEmean <- aggregate(MLE ~ distance, data=nCO2R, mean)
AO2RMLEmean <- aggregate(MLE ~ distance, data=AO2R, mean)
BO2RMLEmean <- aggregate(MLE ~ distance, data=BO2R, mean)
BX2RMLEmean <- aggregate(MLE ~ distance, data=BX2R, mean)

#sum distance categories (check for overabundance of 11, 22, 33, etc)
#plot(table(ACO2R$distance))
head(table(ACO2R$distance), 10)
#plot(table(CO2R$distance))
head(table(CO2R$distance), 10)
#plot(table(nCO2R$distance))
head(table(nCO2R$distance), 10)
#plot(table(AO2R$distance))
head(table(AO2R$distance), 10)
#plot(table(BO2R$distance))
head(table(BO2R$distance), 10)
#plot(table(BX2R$distance))
head(table(BX2R$distance), 10)

#plot average points
#CO vs ACO

pdf(file="2R/LD2R.pdf")

#plot in one figure
par(mfrow=c(3,1))

plot(subset(CO2RMLEmean, distance > 10), pch=19, 
     main="LD(MLE) for CO(black) and ACO(red) on 2R", 
     ylim=c(0.2,0.8))
points(subset(ACO2RMLEmean, distance > 10), col="red")

#nCO vs AO
plot(subset(nCO2RMLEmean, distance > 10), pch=19, 
     main="LD(MLE) for nCO(black) and AO(red) on 2R",
     ylim=c(0.2,0.8))
points(subset(AO2RMLEmean, distance > 10), col="red")

#BO vs BX
plot(subset(BO2RMLEmean, distance > 10), pch=19, 
     main="LD(MLE) for BO(black) and B(red) on 2R",
     ylim=c(0.2,0.8))
points(subset(BX2RMLEmean, distance > 10), col="red")

dev.off()