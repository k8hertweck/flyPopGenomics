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
		#2R
		echo "$p 2R"
		samtools view -h $WORK/${p}*.bam '2R' > $WORK/2R/${p}2R.sam
		samtools mpileup -uIf 2R/2R.dmel.RELEASE5 $WORK/${p}_merge.bam | bcftools view -v snps | vcfutils.pl varFilter > $SCRATCH/2R/${p}2R.flt.vcf
		perl $HOME/bin/LDx.pl -l 20 -h 100 -s 200 -q 20 -a 0.1 -i 11 $WORK/2R/${p}2R.sam $SCRATCH/2R/${p}2R.flt.vcf > 2R/${p}2R.flt.out
	done
