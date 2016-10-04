###LD decay

#data import
LDxheader <- c("locationSNP1","locationSNP2","x_11","x_12","x_21","x_22","freqA","freqB","depthSNP1","depthSNP2","isectReadDepth","lowMLE","MLE","highMLE","directR2","A","a","B","b")

###2L
#combine population results into a single file
system('cat 2L/ACO*.flt.out > 2L/ACO2L.out')
system('cat 2L/CO*.flt.out > 2L/CO2L.out')
system('cat 2L/nCO*.flt.out > 2L/nCO2L.out')
system('cat 2L/AO*.flt.out > 2L/AO2L.out')
system('cat 2L/BO*.flt.out > 2L/BO2L.out')
system('cat 2L/BX*.flt.out > 2L/BX2L.out')

#read file
ACO2L <- read.delim(file = "2L/ACO2L.out", header = FALSE, col.names = LDxheader)
CO2L <- read.delim(file = "2L/CO2L.out", header = FALSE, col.names = LDxheader)
nCO2L <- read.delim(file = "2L/nCO2L.out", header = FALSE, col.names = LDxheader)
AO2L <- read.delim(file = "2L/AO2L.out", header = FALSE, col.names = LDxheader)
BO2L <- read.delim(file = "2L/BO2L.out", header = FALSE, col.names = LDxheader)
BX2L <- read.delim(file = "2L/BX2L.out", header = FALSE, col.names = LDxheader)

#add distance
ACO2L <- transform(ACO2L, distance = ACO2L$locationSNP2 - ACO2L$locationSNP1)
CO2L <- transform(CO2L, distance = CO2L$locationSNP2 - CO2L$locationSNP1)
nCO2L <- transform(nCO2L, distance = nCO2L$locationSNP2 - nCO2L$locationSNP1)
AO2L <- transform(AO2L, distance = AO2L$locationSNP2 - AO2L$locationSNP1)
BO2L <- transform(BO2L, distance = BO2L$locationSNP2 - BO2L$locationSNP1)
BX2L <- transform(BX2L, distance = BX2L$locationSNP2 - BX2L$locationSNP1)

#average MLE and R2 for each distance and replot
ACO2LMLEmean <- aggregate(MLE ~ distance, data=ACO2L, mean)
CO2LMLEmean <- aggregate(MLE ~ distance, data=CO2L, mean)
nCO2LMLEmean <- aggregate(MLE ~ distance, data=nCO2L, mean)
AO2LMLEmean <- aggregate(MLE ~ distance, data=AO2L, mean)
BO2LMLEmean <- aggregate(MLE ~ distance, data=BO2L, mean)
BX2LMLEmean <- aggregate(MLE ~ distance, data=BX2L, mean)

#sum distance categories (check for overabundance of 11, 22, 33, etc)
#plot(table(ACO2L$distance))
head(table(ACO2L$distance), 10)
#plot(table(CO2L$distance))
head(table(CO2L$distance), 10)
#plot(table(nCO2L$distance))
head(table(nCO2L$distance), 10)
#plot(table(AO2L$distance))
head(table(AO2L$distance), 10)
#plot(table(BO2L$distance))
head(table(BO2L$distance), 10)
#plot(table(BX2L$distance))
head(table(BX2L$distance), 10)

#plot average points
#CO vs ACO

pdf(file="2L/LD2L.pdf")

#plot in one figure
par(mfrow=c(3,1))

plot(subset(CO2LMLEmean, distance > 10), pch=19, 
     main="LD(MLE) for CO(black) and ACO(red) on 2L", 
     ylim=c(0.2,0.8))
points(subset(ACO2LMLEmean, distance > 10), col="red")

#nCO vs AO
plot(subset(nCO2LMLEmean, distance > 10), pch=19, 
     main="LD(MLE) for nCO(black) and AO(red) on 2L",
     ylim=c(0.2,0.8))
points(subset(AO2LMLEmean, distance > 10), col="red")

#BO vs BX
plot(subset(BO2LMLEmean, distance > 10), pch=19, 
     main="LD(MLE) for BO(black) and B(red) on 2L",
     ylim=c(0.2,0.8))
points(subset(BX2LMLEmean, distance > 10), col="red")

dev.off()
