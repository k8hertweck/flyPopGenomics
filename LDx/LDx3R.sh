#!/bin/bash
##map reads and run LDx

#dependencies:
module load samtools
#	bcftools
#	vcfutils.pl
#	LDx.pl
#	directories in $WORK and $FLY for each chromosome; genome sequence for each in the latter

for p in `cat pop.lst`
	do

		#3R
		echo "$p 3R"
		samtools view -h $WORK/${p}*.bam '3R' > $WORK/3R/${p}3R.sam
		samtools mpileup -uIf 3R/3R.dmel.RELEASE5 $WORK/${p}_merge.bam | bcftools view -v snps | vcfutils.pl varFilter > $SCRATCH/3R/${p}3R.flt.vcf
		perl $HOME/bin/LDx.pl -l 20 -h 100 -s 200 -q 20 -a 0.1 -i 11 $WORK/3R/${p}3R.sam $SCRATCH/3R/${p}3R.flt.vcf > 3R/${p}3R.flt.out
	done
