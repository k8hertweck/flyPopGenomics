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
		#X
		echo "$p X"
		samtools view -h $WORK/${p}*.bam 'X' > $WORK/X/${p}X.sam
		samtools mpileup -uIf X/X.dmel.RELEASE5 $WORK/${p}_merge.bam | bcftools view -v snps | vcfutils.pl varFilter > $SCRATCH/X/${p}X.flt.vcf
		perl $HOME/bin/LDx.pl -l 20 -h 100 -s 200 -q 20 -a 0.1 -i 11 $WORK/X/${p}X.sam $SCRATCH/X/${p}X.flt.vcf > X/${p}X.flt.out
		
	done
		
