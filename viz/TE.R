## Visualization of fly TE results for Graves et al

library(dplyr)

## PoPoolationTE results
files <- list.files("~/Dropbox/flydata/popoolation/results", pattern="txt")

# read in files
hierarchy <- read.table("../popoolationTE/TEtemplate.txt")
header <- read.table("te-polyfiltered.header.txt", header=FALSE)
dat <- read.delim("~/Dropbox/flydata/popoolation/results/ACO1te-poly-filtered.txt", header=FALSE)
colnames(dat) <- as.matrix(header)

# find list of TEs


# filter data
chrom <- c("2R","2L","3R","3L","X")
fam_counts <- dat %>% filter(ID %in% chrom) %>% 
  filter(F_R == "FR") %>% 
  filter(refID =="-") %>%
  group_by(family) %>%
  summarise(n = n())
