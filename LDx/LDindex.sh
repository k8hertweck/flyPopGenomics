#!/bin/bash

#dependencies: samtools
#index sam file

for p in `cat pop2.lst`
	do
	echo "$p"
	samtools index $WORK/${p}_merge.bam
done
