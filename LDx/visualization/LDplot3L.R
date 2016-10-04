###LD decay

#data import
LDxheader <- c("locationSNP1","locationSNP2","x_11","x_12","x_21","x_22","freqA","freqB","depthSNP1","depthSNP2","isectReadDepth","lowMLE","MLE","highMLE","directR2","A","a","B","b")

###3L
#combine population results into a single file
system('cat 3L/ACO*.flt.out > 3L/ACO3L.out')
system('cat 3L/CO*.flt.out > 3L/CO3L.out')
system('cat 3L/nCO*.flt.out > 3L/nCO3L.out')
system('cat 3L/AO*.flt.out > 3L/AO3L.out')
system('cat 3L/BO*.flt.out > 3L/BO3L.out')
system('cat 3L/BX*.flt.out > 3L/BX3L.out')

#read file
ACO3L <- read.delim(file = "3L/ACO3L.out", header = FALSE, col.names = LDxheader)
CO3L <- read.delim(file = "3L/CO3L.out", header = FALSE, col.names = LDxheader)
nCO3L <- read.delim(file = "3L/nCO3L.out", header = FALSE, col.names = LDxheader)
AO3L <- read.delim(file = "3L/AO3L.out", header = FALSE, col.names = LDxheader)
BO3L <- read.delim(file = "3L/BO3L.out", header = FALSE, col.names = LDxheader)
BX3L <- read.delim(file = "3L/BX3L.out", header = FALSE, col.names = LDxheader)

#add distance
ACO3L <- transform(ACO3L, distance = ACO3L$locationSNP2 - ACO3L$locationSNP1)
CO3L <- transform(CO3L, distance = CO3L$locationSNP2 - CO3L$locationSNP1)
nCO3L <- transform(nCO3L, distance = nCO3L$locationSNP2 - nCO3L$locationSNP1)
AO3L <- transform(AO3L, distance = AO3L$locationSNP2 - AO3L$locationSNP1)
BO3L <- transform(BO3L, distance = BO3L$locationSNP2 - BO3L$locationSNP1)
BX3L <- transform(BX3L, distance = BX3L$locationSNP2 - BX3L$locationSNP1)

#average MLE and R2 for each distance and replot
ACO3LMLEmean <- aggregate(MLE ~ distance, data=ACO3L, mean)
CO3LMLEmean <- aggregate(MLE ~ distance, data=CO3L, mean)
nCO3LMLEmean <- aggregate(MLE ~ distance, data=nCO3L, mean)
AO3LMLEmean <- aggregate(MLE ~ distance, data=AO3L, mean)
BO3LMLEmean <- aggregate(MLE ~ distance, data=BO3L, mean)
BX3LMLEmean <- aggregate(MLE ~ distance, data=BX3L, mean)

#sum distance categories (check for overabundance of 11, 22, 33, etc)
#plot(table(ACO3L$distance))
head(table(ACO3L$distance), 10)
#plot(table(CO3L$distance))
head(table(CO3L$distance), 10)
#plot(table(nCO3L$distance))
head(table(nCO3L$distance), 10)
#plot(table(AO3L$distance))
head(table(AO3L$distance), 10)
#plot(table(BO3L$distance))
head(table(BO3L$distance), 10)
#plot(table(BX3L$distance))
head(table(BX3L$distance), 10)

#plot average points
#CO vs ACO

pdf(file="3L/LD3L.pdf")

#plot in one figure
par(mfrow=c(3,1))

plot(subset(CO3LMLEmean, distance > 10), pch=19, 
     main="LD(MLE) for CO(black) and ACO(red) on 3L", 
     ylim=c(0.2,0.8))
points(subset(ACO3LMLEmean, distance > 10), col="red")

#nCO vs AO
plot(subset(nCO3LMLEmean, distance > 10), pch=19, 
     main="LD(MLE) for nCO(black) and AO(red) on 3L",
     ylim=c(0.2,0.8))
points(subset(AO3LMLEmean, distance > 10), col="red")

#BO vs BX
plot(subset(BO3LMLEmean, distance > 10), pch=19, 
     main="LD(MLE) for BO(black) and B(red) on 3L",
     ylim=c(0.2,0.8))
points(subset(BX3LMLEmean, distance > 10), col="red")

dev.off()