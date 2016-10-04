# aggregate and run paired t-tests on popoolationTE results

library(dplyr)

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

## First run only
# popoolation results
files <- list.files("~/Dropbox/flydata/popoolation/firstRunResults", pattern="txt", full.names = TRUE)
hierarchy <- read.table("~/GitHub/flyPopGenomics/popoolationTE/TEtemplate.txt")
hierarchy <- hierarchy[,c(1,5)]
colnames(hierarchy) <- c("family", "type")
header <- read.table("~/GitHub/flyPopGenomics/viz/te-polyfiltered.header.txt", header=FALSE)
chrom <- c("2R","2L","3R","3L","X")

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

## Subsampled
# popoolation results
files <- list.files("popoolationTE/subsampledResults", pattern="txt", full.names = TRUE)
hierarchy <- read.table("~/GitHub/flyPopGenomics/popoolationTE/TEtemplate.txt")
hierarchy <- hierarchy[,c(1,5)]
colnames(hierarchy) <- c("family", "type")
header <- read.table("~/GitHub/flyPopGenomics/viz/te-polyfiltered.header.txt", header=FALSE)
chrom <- c("2R","2L","3R","3L","X")

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

## both runs combined
# popoolation results
files <- list.files("~/Dropbox/flydata/popoolation/combinedResults", pattern="txt", full.names = TRUE)
hierarchy <- read.table("~/GitHub/flyPopGenomics/popoolationTE/TEtemplate.txt")
hierarchy <- hierarchy[,c(1,5)]
colnames(hierarchy) <- c("family", "type")
header <- read.table("~/GitHub/flyPopGenomics/viz/te-polyfiltered.header.txt", header=FALSE)
chrom <- c("2R","2L","3R","3L","X")

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

