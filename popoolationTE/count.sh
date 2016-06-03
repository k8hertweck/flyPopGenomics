#!/bin/bash

FILES=$(ls */te-poly-filtered*.txt)

echo "PoPoolationTE counts" > popoolation.counts

for f in $FILES
do
	echo "$f" >> popoolation.counts
	wc -l $f >> popoolation.counts
	cat $f | awk '{print $4}' | sort -f | uniq -c >> popoolation.counts

done