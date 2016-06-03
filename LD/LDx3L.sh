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

		#3L
		echo "$p 3L"
		samtools view -h $WORK/${p}*.bam '3L' > $WORK/3L/${p}3L.sam
		samtools mpileup -uIf 3L/3L.dmel.RELEASE5 $WORK/${p}_merge.bam | bcftools view -v snps | vcfutils.pl varFilter > $SCRATCH/3L/${p}3L.flt.vcf
		perl $HOME/bin/LDx.pl -l 20 -h 100 -s 200 -q 20 -a 0.1 -i 11 $WORK/3L/${p}3L.sam $SCRATCH/3L/${p}3L.flt.vcf > 3L/${p}3L.flt.out
	done
