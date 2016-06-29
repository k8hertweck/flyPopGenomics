#!/bin/bash

## aggregating results from PoPoolationTE

##creates:
#	popoolationResults.csv
## required:
#	*te-poly-filtered.txt from each population
#	te-polyfiltered.header.txt

cd ~/Dropbox/flydata/popoolation/results

## sort, remove non-chromosomal insertions, insertions not supported by F & R, insertions from reference genome
cd raw
for x in *.txt
	do 
		dat=`sort $x | awk '($1 =="2L" || $1 =="2R" || $1=="3L" || $1=="3R" || $1=="X") && ($3=="FR") && ($7=="-") {print $1,$2,$4,$5,$13,$14,$19,$20}'`
		echo -e "ID pos family popfreq FreadsP FreadsA RreadsP RreadsA\n$dat" > ../filtered/$x
done
