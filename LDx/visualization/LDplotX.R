###LD decay

#data import
LDxheader <- c("locationSNP1","locationSNP2","x_11","x_12","x_21","x_22","freqA","freqB","depthSNP1","depthSNP2","isectReadDepth","lowMLE","MLE","highMLE","directR2","A","a","B","b")

###X
#combine population results into a single file
system('cat X/ACO*.flt.out > X/ACOX.out')
system('cat X/CO*.flt.out > X/COX.out')
system('cat X/nCO*.flt.out > X/nCOX.out')
system('cat X/AO*.flt.out > X/AOX.out')
system('cat X/BO*.flt.out > X/BOX.out')
system('cat X/BX*.flt.out > X/BXX.out')

#read file
ACOX <- read.delim(file = "X/ACOX.out", header = FALSE, col.names = LDxheader)
COX <- read.delim(file = "X/COX.out", header = FALSE, col.names = LDxheader)
nCOX <- read.delim(file = "X/nCOX.out", header = FALSE, col.names = LDxheader)
AOX <- read.delim(file = "X/AOX.out", header = FALSE, col.names = LDxheader)
BOX <- read.delim(file = "X/BOX.out", header = FALSE, col.names = LDxheader)
BXX <- read.delim(file = "X/BXX.out", header = FALSE, col.names = LDxheader)

#add distance
ACOX <- transform(ACOX, distance = ACOX$locationSNP2 - ACOX$locationSNP1)
COX <- transform(COX, distance = COX$locationSNP2 - COX$locationSNP1)
nCOX <- transform(nCOX, distance = nCOX$locationSNP2 - nCOX$locationSNP1)
AOX <- transform(AOX, distance = AOX$locationSNP2 - AOX$locationSNP1)
BOX <- transform(BOX, distance = BOX$locationSNP2 - BOX$locationSNP1)
BXX <- transform(BXX, distance = BXX$locationSNP2 - BXX$locationSNP1)

#average MLE and R2 for each distance and replot
ACOXMLEmean <- aggregate(MLE ~ distance, data=ACOX, mean)
COXMLEmean <- aggregate(MLE ~ distance, data=COX, mean)
nCOXMLEmean <- aggregate(MLE ~ distance, data=nCOX, mean)
AOXMLEmean <- aggregate(MLE ~ distance, data=AOX, mean)
BOXMLEmean <- aggregate(MLE ~ distance, data=BOX, mean)
BXXMLEmean <- aggregate(MLE ~ distance, data=BXX, mean)

#sum distance categories (check for overabundance of 11, 22, 33, etc)
#plot(table(ACOX$distance))
head(table(ACOX$distance), 10)
#plot(table(COX$distance))
head(table(COX$distance), 10)
#plot(table(nCOX$distance))
head(table(nCOX$distance), 10)
#plot(table(AOX$distance))
head(table(AOX$distance), 10)
#plot(table(BOX$distance))
head(table(BOX$distance), 10)
#plot(table(BXX$distance))
head(table(BXX$distance), 10)

#plot average points
#CO vs ACO

pdf(file="figures/LDX.pdf")

#plot in one figure
par(mfrow=c(3,1))

plot(subset(COXMLEmean, distance > 10), pch=19, 
     main="LD(MLE) for CO(black) and ACO(red) on X", 
     ylim=c(0.2,0.8))
points(subset(ACOXMLEmean, distance > 10), col="red")

#nCO vs AO
plot(subset(nCOXMLEmean, distance > 10), pch=19, 
     main="LD(MLE) for nCO(black) and AO(red) on X",
     ylim=c(0.2,0.8))
points(subset(AOXMLEmean, distance > 10), col="red")

#NCO vs CO
plot(subset(nCOXMLEmean, distance > 10), pch=19, 
     main="LD(MLE) for nCO(black) and CO(red) on X",
     ylim=c(0.2,0.8))
points(subset(COXMLEmean, distance > 10), col="red")

#ACO vs AO
plot(subset(ACOXMLEmean, distance > 10), pch=19, 
     main="LD(MLE) for ACO(black) and AO(red) on X",
     ylim=c(0.2,0.8))
points(subset(AOXMLEmean, distance > 10), col="red")

#BO vs BX
plot(subset(BOXMLEmean, distance > 10), pch=19, 
     main="LD(MLE) for BO(black) and B(red) on X",
     ylim=c(0.2,0.8))
points(subset(BXXMLEmean, distance > 10), col="red")

dev.off()