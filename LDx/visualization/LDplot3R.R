###LD decay

#data import
LDxheader <- c("locationSNP1","locationSNP2","x_11","x_12","x_21","x_22","freqA","freqB","depthSNP1","depthSNP2","isectReadDepth","lowMLE","MLE","highMLE","directR2","A","a","B","b")

###3R
#combine population results into a single file
system('cat 3R/ACO*.flt.out > 3R/ACO3R.out')
system('cat 3R/CO*.flt.out > 3R/CO3R.out')
system('cat 3R/nCO*.flt.out > 3R/nCO3R.out')
system('cat 3R/AO*.flt.out > 3R/AO3R.out')
system('cat 3R/BO*.flt.out > 3R/BO3R.out')
system('cat 3R/BX*.flt.out > 3R/BX3R.out')

#read file
ACO3R <- read.delim(file = "3R/ACO3R.out", header = FALSE, col.names = LDxheader)
CO3R <- read.delim(file = "3R/CO3R.out", header = FALSE, col.names = LDxheader)
nCO3R <- read.delim(file = "3R/nCO3R.out", header = FALSE, col.names = LDxheader)
AO3R <- read.delim(file = "3R/AO3R.out", header = FALSE, col.names = LDxheader)
BO3R <- read.delim(file = "3R/BO3R.out", header = FALSE, col.names = LDxheader)
BX3R <- read.delim(file = "3R/BX3R.out", header = FALSE, col.names = LDxheader)

#add distance
ACO3R <- transform(ACO3R, distance = ACO3R$locationSNP2 - ACO3R$locationSNP1)
CO3R <- transform(CO3R, distance = CO3R$locationSNP2 - CO3R$locationSNP1)
nCO3R <- transform(nCO3R, distance = nCO3R$locationSNP2 - nCO3R$locationSNP1)
AO3R <- transform(AO3R, distance = AO3R$locationSNP2 - AO3R$locationSNP1)
BO3R <- transform(BO3R, distance = BO3R$locationSNP2 - BO3R$locationSNP1)
BX3R <- transform(BX3R, distance = BX3R$locationSNP2 - BX3R$locationSNP1)

#average MLE and R2 for each distance and replot
ACO3RMLEmean <- aggregate(MLE ~ distance, data=ACO3R, mean)
CO3RMLEmean <- aggregate(MLE ~ distance, data=CO3R, mean)
nCO3RMLEmean <- aggregate(MLE ~ distance, data=nCO3R, mean)
AO3RMLEmean <- aggregate(MLE ~ distance, data=AO3R, mean)
BO3RMLEmean <- aggregate(MLE ~ distance, data=BO3R, mean)
BX3RMLEmean <- aggregate(MLE ~ distance, data=BX3R, mean)

#sum distance categories (check for overabundance of 11, 22, 33, etc)
#plot(table(ACO3R$distance))
head(table(ACO3R$distance), 10)
#plot(table(CO3R$distance))
head(table(CO3R$distance), 10)
#plot(table(nCO3R$distance))
head(table(nCO3R$distance), 10)
#plot(table(AO3R$distance))
head(table(AO3R$distance), 10)
#plot(table(BO3R$distance))
head(table(BO3R$distance), 10)
#plot(table(BX3R$distance))
head(table(BX3R$distance), 10)

#plot average points
#CO vs ACO

pdf(file="3R/LD3R.pdf")

#plot in one figure
par(mfrow=c(3,1))

plot(subset(CO3RMLEmean, distance > 10), pch=19, 
     main="LD(MLE) for CO(black) and ACO(red) on 3R", 
     ylim=c(0.2,0.8))
points(subset(ACO3RMLEmean, distance > 10), col="red")

#nCO vs AO
plot(subset(nCO3RMLEmean, distance > 10), pch=19, 
     main="LD(MLE) for nCO(black) and AO(red) on 3R",
     ylim=c(0.2,0.8))
points(subset(AO3RMLEmean, distance > 10), col="red")

#BO vs BX
plot(subset(BO3RMLEmean, distance > 10), pch=19, 
     main="LD(MLE) for BO(black) and B(red) on 3R",
     ylim=c(0.2,0.8))
points(subset(BX3RMLEmean, distance > 10), col="red")

dev.off()