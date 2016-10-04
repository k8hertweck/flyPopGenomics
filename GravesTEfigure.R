#TE analysis and figure construction for Graves et al.

library(dplyr)
library(ggplot2)
library(wesanderson)

#create heterozygosity function
heterozygosity <- function(freq)
{
  count_A <- freq[,c(1:61) %% 2 != 0]
  count_a <- freq[,c(1:61) %% 2 == 0]
  count_A <- count_A[,2:31]
  count_a <- count_a[,1:30]
  freq_a <- count_a/(count_a+count_A)
  het <- 1-freq_a^2-(1-freq_a)^2
  het <- cbind(freq$ID, freq$chr, freq$start, freq$end, data.frame(het))
  het
}

#create Fst function
Fst <- function(freq, Het, i, j)
{
  count_A <- freq[,c(1:61) %% 2 != 0]
  count_a <- freq[,c(1:61) %% 2 == 0]
  count_A <- count_A[,2:31]
  count_a <- count_a[,1:30]
  count_a_ij <- count_a[,i]+count_a[,j]
  count_A_ij <- count_A[,i]+count_A[,j]
  freq_a_ij <- count_a_ij/(count_a_ij+count_A_ij)
  het_ij <- 1-freq_a_ij^2-(1-freq_a_ij)^2
  het_s <- (Het[,4+i]*(count_a[,i]+count_A[,i])+Het[,4+j]*(count_a[,j]+count_A[,j]))/(count_a[,i]+count_A[,i]+count_a[,j]+count_A[,j])
  # 4 is added to shift away ID, chr, start and end
  Fst <- (het_ij-het_s)/het_ij
  Fst
}

#read in read counts of variable TEs (rounded up)
freq <- read.table("tlex2/results/TE.reads.varup.csv", sep=" ", header=FALSE)
colnames(freq) <- c("ID", "rep1_B_1", "rep1_B_0", "rep1_CO_1", "rep1_CO_0", "rep1_ACO_1", "rep1_ACO_0", "rep1_NCO_1", "rep1_NCO_0", "rep1_AO_1", "rep1_AO_0", "rep1_BO_1", "rep1_BO_0", "rep2_B_1", "rep2_B_0", "rep2_CO_1", "rep2_CO_0", "rep2_ACO_1", "rep2_ACO_0", "rep2_NCO_1", "rep2_NCO_0", "rep2_AO_1", "rep2_AO_0", "rep2_BO_1", "rep2_BO_0", "rep3_B_1", "rep3_B_0", "rep3_CO_1", "rep3_CO_0", "rep3_ACO_1", "rep3_ACO_0", "rep3_NCO_1", "rep3_NCO_0", "rep3_AO_1", "rep3_AO_0", "rep3_BO_1", "rep3_BO_0", "rep4_B_1", "rep4_B_0", "rep4_CO_1", "rep4_CO_0", "rep4_ACO_1", "rep4_ACO_0", "rep4_NCO_1", "rep4_NCO_0", "rep4_AO_1", "rep4_AO_0", "rep4_BO_1", "rep4_BO_0", "rep5_B_1", "rep5_B_0", "rep5_CO_1", "rep5_CO_0", "rep5_ACO_1", "rep5_ACO_0", "rep5_NCO_1", "rep5_NCO_0", "rep5_AO_1", "rep5_AO_0", "rep5_BO_1", "rep5_BO_0", "blank", "support", "chr", "start", "end")

#calculate heterozygosity
het1 <- heterozygosity(freq)
summary(het1)

#het by treatment
attach(het1)
hetB <- rowMeans(cbind(rep1_B_1, rep2_B_1, rep3_B_1, rep4_B_1, rep5_B_1), na.rm=TRUE)
hetBO <- rowMeans(cbind(rep1_BO_1, rep2_BO_1, rep3_BO_1, rep4_BO_1, rep5_BO_1), na.rm=TRUE)
hetCO <- rowMeans(cbind(rep1_CO_1, rep2_CO_1, rep3_CO_1, rep4_CO_1, rep5_CO_1), na.rm=TRUE)
hetACO <- rowMeans(cbind(rep1_ACO_1, rep2_ACO_1, rep3_ACO_1, rep4_ACO_1, rep5_ACO_1), na.rm=TRUE)
hetnCO <- rowMeans(cbind(rep1_NCO_1, rep2_NCO_1, rep3_NCO_1, rep4_NCO_1, rep5_NCO_1), na.rm=TRUE)
hetAO <- rowMeans(cbind(rep1_AO_1, rep2_AO_1, rep3_AO_1, rep4_AO_1, rep5_AO_1), na.rm=TRUE)

#calculate Fst
Fst_r1_CO_ACO <- Fst(freq, het1, 2, 3)
Fst_r1_NCO_AO <- Fst(freq, het1, 4, 5)
Fst_r1_NCO_CO <- Fst(freq, het1, 4, 2)
Fst_r1_ACO_AO <- Fst(freq, het1, 3, 5)
Fst_r1_BO_B <- Fst(freq, het1, 1, 6)
Fst_r2_CO_ACO <- Fst(freq, het1, 8, 9)
Fst_r2_NCO_AO <- Fst(freq, het1, 10, 11)
Fst_r2_NCO_CO <- Fst(freq, het1, 10, 8)
Fst_r2_ACO_AO <- Fst(freq, het1, 9, 11)
Fst_r2_BO_B <- Fst(freq, het1, 7, 12)
Fst_r3_CO_ACO <- Fst(freq, het1, 14, 15)
Fst_r3_NCO_AO <- Fst(freq, het1, 16, 17)
Fst_r3_NCO_CO <- Fst(freq, het1, 16, 14)
Fst_r3_ACO_AO <- Fst(freq, het1, 15, 17)
Fst_r3_BO_B <- Fst(freq, het1, 13, 18)
Fst_r4_CO_ACO <- Fst(freq, het1, 20, 21)
Fst_r4_NCO_AO <- Fst(freq, het1, 22, 23)
Fst_r4_NCO_CO <- Fst(freq, het1, 22, 20)
Fst_r4_ACO_AO <- Fst(freq, het1, 21, 23)
Fst_r4_BO_B <- Fst(freq, het1, 19, 24)
Fst_r5_CO_ACO <- Fst(freq, het1, 26, 27)
Fst_r5_NCO_AO <- Fst(freq, het1, 28, 29)
Fst_r5_NCO_CO <- Fst(freq, het1, 28, 26)
Fst_r5_ACO_AO <- Fst(freq, het1, 27, 29)
Fst_r5_BO_B <- Fst(freq, het1, 25, 30)

COACOFst <- rowMeans(cbind(Fst_r1_CO_ACO, Fst_r2_CO_ACO, Fst_r3_CO_ACO, Fst_r4_CO_ACO, Fst_r5_CO_ACO), na.rm=TRUE)
NCOAOFst <- rowMeans(cbind(Fst_r1_NCO_AO, Fst_r2_NCO_AO, Fst_r3_NCO_AO, Fst_r4_NCO_AO, Fst_r5_NCO_AO), na.rm=TRUE)
NCOCOFst <- rowMeans(cbind(Fst_r1_NCO_CO, Fst_r2_NCO_CO, Fst_r3_NCO_CO, Fst_r4_NCO_CO, Fst_r5_NCO_CO), na.rm=TRUE)
ACOAOFst <- rowMeans(cbind(Fst_r1_ACO_AO, Fst_r2_ACO_AO, Fst_r3_ACO_AO, Fst_r4_ACO_AO, Fst_r5_ACO_AO), na.rm=TRUE)
BOBFst <- rowMeans(cbind(Fst_r1_BO_B, Fst_r2_BO_B, Fst_r3_BO_B, Fst_r4_BO_B, Fst_r5_BO_B), na.rm=TRUE)

#import variable, bon corrected CMH pvalues
cmh <- read.csv(file="tlex2/results/TE.cmh.tax.csv", header=TRUE, sep=" ")
cmhheader <- c("B vs. BO", "CO vs. nCO", "ACO vs. AO", "CO vs. ACO", "nCO vs. AO", "C vs. A", "all")

#parse file by significant values
attach(cmh)
all <- type
CA <- cmh[which(pvals_C_A < 0.05),23]
COACO <- cmh[which(pvals_ACO_CO < 0.05),23]
NCOAO <- cmh[which(pvals_AO_NCO < 0.05),23]
CONCO <- cmh[which(pvals_CO_NCO < 0.05),23]
ACOAO <- cmh[which(pvals_ACO_AO < 0.05),23]
BBO <- cmh[which(pvals_B_BOord < 0.05),23]

cmhtallytable <- cbind(table(BBO), table(CONCO), table(ACOAO), table(COACO), table(NCOAO), table(CA), table(all))
colnames(cmhtallytable) <- cmhheader

length(all) -> x
length(CA) <- x
length(COACO) <- x
length(NCOAO) <- x
length(CONCO) <- x
length(ACOAO) <- x
length(BBO) <- x
cmhuglytable <- cbind.data.frame(all, CA, COACO, NCOAO, CONCO, ACOAO, BBO)
colnames(cmhuglytable) <- cmhheader

# popoolation results
files <- list.files("popoolationTE/subsampledResults", pattern="txt", full.names = TRUE)
hierarchy <- read.table("popoolationTE/TEtemplate.txt")
hierarchy <- hierarchy[,c(1,5)]
colnames(hierarchy) <- c("family", "type")
header <- read.table("popoolationTE/te-polyfiltered.header.txt", header=FALSE)
chrom <- c("2R","2L","3R","3L","X")

# create function to count number of each TE family by population
countTEs <- function(filename){
  dat <- read.delim(filename, header=FALSE)
  colnames(dat) <- as.matrix(header)
  dat <- merge(hierarchy, (dat %>% filter(ID %in% chrom) %>% 
                             filter(F_R == "FR") %>% 
                             filter(refID =="-") %>%
                             group_by(family) %>%
                             tally()), all.x=TRUE, by="family") 
}

# aggregate popoolationTE counts for all populations
countTable <- hierarchy
for (name in files){
  print(name)
  countTable <- merge(countTable, countTEs(name), by.x=c("family", "type"), by.y=c("family", "type"))
}
colnames(countTable) <- c("family","type","ACO1","ACO2","ACO3","ACO4","ACO5","AO1","AO2","AO3","AO4","AO5","B1","B2","B3","B4","B5","BO1","BO2","BO3","BO4","BO5","CO1","CO2","CO3","CO4","CO5","nCO1","nCO2","nCO3","nCO4","nCO5")
popSums <- apply(countTable[,3:32], 2, sum, na.rm=TRUE)

# statistical comparisons for popoolationTE
ACO <- popSums[1:5] 
AO <- popSums[6:10]
B <- popSums[11:15]
BO <- popSums[16:20]
CO <- popSums[21:25]
nCO <- popSums[26:30]
t.test(ACO, AO, paired=TRUE)
t.test(B, BO, paired=TRUE)
t.test(CO, nCO, paired=TRUE)
t.test(CO, ACO, paired=TRUE, alternative="less")
t.test(nCO, AO, paired=TRUE, alternative="less")

#final plot
tiff(file="Figure2TE.tiff", height=150, width=183, units = 'mm', res = 300)
par(mfrow=c(2,2))

#A bar plot of de novo results by TE type
popSums <- c(B,BO,CO,nCO,ACO,AO)
barplot(popSums, col=c("red","red","red","red","red","red 4","red 4","red 4","red 4","red 4","green","green","green","green","green","green 4","green 4","green 4","green 4","green 4","blue","blue","blue","blue","blue","blue 4","blue 4","blue 4","blue 4","blue 4"), names.arg = "", xlab="B       BO      CO      nCO     ACO     AO", ylab="number of de novo TE insertions", cex.lab=0.9, ylim = c(0, 1400))
mtext("a", side=3, line=2, adj=-0.25)

#B boxplot of heterozygosity
hetheader <- c("B", "BO", "CO", "nCO", "ACO", "AO")
combinedhet <- cbind(hetB, hetBO, hetCO, hetnCO, hetACO, hetAO)
colnames(combinedhet) <- hetheader
boxplot(combinedhet, ylab="Mean heterozygosity of TE insertions", cex.axis=0.8, cex.lab=0.8, col=c("red","red 4","green","green 4","blue","blue 4"))
mtext("b", side=3, line=2, adj=-0.25)
#qplot(data=combinedhet, geom="boxplot")

#C boxplot of Fst
#Fstheader <- c("B vs. BO", "CO vs. nCO", "ACO vs. AO", "CO vs ACO", "nCO vs. AO")
combinedFst <- cbind(BOBFst, NCOCOFst, ACOAOFst, COACOFst, NCOAOFst)
#colnames(combinedFst) <- Fstheader
par(mar = (c(6, 5, 4, 2)))
boxplot(combinedFst, ylab="Mean Fst for TE insertions", names=rep("", 5))
mtext("B", side=1, line=1, at=1, font=2, col="red 4", cex=0.7)
mtext("CO", side=1, line=1, at=2, font=2, col="green 4", cex=0.7)
mtext("ACO", side=1, line=1, at=3, font=2, col="blue 4", cex=0.7)
mtext("CO", side=1, line=1, at=4, font=2, col="green 4", cex=0.7)
mtext("nCO", side=1, line=1, at=5, font=2, col="green 4", cex=0.7)
mtext("vs", side=1, line=2, at=c(1:5), font=2, cex=0.7)
mtext("BO", side=1, line=3, at=1, font=2, col="red 4", cex=0.7)
mtext("nCO", side=1, line=3, at=2, font=2, col="green 4", cex=0.7)
mtext("AO", side=1, line=3, at=3, font=2, col="blue 4", cex=0.7)
mtext("ACO", side=1, line=3, at=4, font=2, col="blue 4", cex=0.7)
mtext("AO", side=1, line=3, at=5, font=2, col="blue 4", cex=0.7)
mtext("c", side=3, line=2, adj=-0.25)

#D bar plot of CMH by TE type
barplot(cmhtallytable, col=wes_palette("Moonrise3"), beside=TRUE, ylab="number of significantly\ndifferentiated TEs", cex.axis=0.9, cex.lab=0.8, names=rep("", 7), ylim=c(0,70))
legend("topleft", legend=rownames(cmhtallytable), fill=wes_palette("Moonrise3"), cex=0.8)
mtext("B", side=1, line=1, at=4, font=2, col="red 4", cex=0.7)
mtext("CO", side=1, line=1, at=10, font=2, col="green 4", cex=0.7)
mtext("ACO", side=1, line=1, at=16, font=2, col="blue 4", cex=0.7)
mtext("CO", side=1, line=1, at=22, font=2, col="green 4", cex=0.7)
mtext("nCO", side=1, line=1, at=28, font=2, col="green 4", cex=0.7)
mtext("C", side=1, line=1, at=34, font=2, col="green 4", cex=0.7)
mtext("all", side=1, line=1, at=40, font=2, cex=0.7)
mtext("vs", side=1, line=2, at=c(4,10,16,22,28,34), font=2, cex=0.7)
mtext("BO", side=1, line=3, at=4, font=2, col="red 4", cex=0.7)
mtext("nCO", side=1, line=3, at=10, font=2, col="green 4", cex=0.7)
mtext("AO", side=1, line=3, at=16, font=2, col="blue 4", cex=0.7)
mtext("ACO", side=1, line=3, at=22, font=2, col="blue 4", cex=0.7)
mtext("AO", side=1, line=3, at=28, font=2, col="blue 4", cex=0.7)
mtext("A", side=1, line=3, at=34, font=2, col="blue 4", cex=0.7)
mtext("d", side=3, line=2, adj=-0.25)

dev.off()
