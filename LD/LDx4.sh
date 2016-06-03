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
		#4
                echo "$p 4"
                samtools view -h $WORK/${p}*.bam '4' > $WORK/4/${p}4.sam
                samtools mpileup -uIf 4/4.dmel.RELEASE5 $WORK/${p}_merge.bam | bcftools view -v snps | vcfutils.pl varFilter > $SCRATCH/4/${p}4.flt.vcf
                perl $HOME/bin/LDx.pl -l 20 -h 100 -s 200 -q 20 -a 0.1 -i 11 $WORK/4/${p}4.sam $SCRATCH/4/${p}4.flt.vcf > 4/${p}4.flt.out

	done
		
