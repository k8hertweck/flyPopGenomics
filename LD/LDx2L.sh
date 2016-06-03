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
		
		#2L
		echo "$p 2L"
		samtools view -h $WORK/${p}*.bam '2L' > $WORK/2L/${p}2L.sam
		samtools mpileup -uIf 2L/2L.dmel.RELEASE5 $WORK/${p}_merge.bam | bcftools view -v snps | vcfutils.pl varFilter > $SCRATCH/2L/${p}2L.flt.vcf
		perl $HOME/bin/LDx.pl -l 20 -h 100 -s 200 -q 20 -a 0.1 -i 11 $WORK/2L/${p}2L.sam $SCRATCH/2L/${p}2L.flt.vcf > 2L/${p}2L.flt.out

	done
