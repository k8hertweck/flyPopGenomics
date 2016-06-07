#!/bin/bash

## prepping input files for popoolationTE

##creates:
#	DmelComb.fas
#	TEhierarchy5.51.tsv
#	TEknown5.51.tsv
## required:
# annotation version 2013 May (FB2013_03 Dmel Release 5.51) downloaded from http://flybase.org/static_pages/downloads/bulkdata7.html
#	dmel-all-transposon-r5.51.fasta.gz
# 	DmelR5.fasta (only chromosomes, with simplified headers)
#	
# TEtemplate.txt: one row per TE, with TE taxonomy/hierarchy specified
# dependencies
#	prinseq (installed to run as prinseq-lite)
#	repeatmasker 4.0.5
 
## creating combined reference genome
# remove unnecessary comments from headers in transposon file
awk '{print $1}' dmel-all-transposon-r5.51.fasta > transposon5.51.fasta

# mask reference fasta file for Dmel genome
repeatmasker -no_is -nolow -norna -lib transposon5.51.fasta -pa 4 DmelR5.fas

# remove sequences shorter than 40
prinseq-lite -fasta transposon5.51.fasta -min_len 40 > transposonLong5.51.fasta

# combine reference genome and TE sequences
cat DmelR5.fas.masked transposonLong5.51.fasta > DmelComb.fas

## creating TE hierarchy file
# insert	id	family	superfamily	suborder	class	problem
# extract header from transposon file 
grep ">" dmel-all-transposon-r5.51.fasta > transposonHeaders.lst

# convert header to first two columns in TE hierarchy file
cut -d " " -f 1,4 transposonHeaders.lst | sed s/\>// | sed s/name=// | sed s/{}.*// | awk '{print $2,$1}' > table1.csv

# join with TE taxonomy table (TE template extracted from original popoolationTE paper and manually curated for capitalization, etc)
join -a 1 <(sort TEtemplate.txt) <(sort table1.csv) | awk '{print $8,$1,$3,$4,$5,$6,$7}' > table2.csv

# add TE hierarchy header and convert to tsv
echo -n "" > TEhierarchy5.51.tsv
echo "insert id family superfamily suborder class problem" | cat - table2.csv | tr " " "\t" >> TEhierarchy5.51.tsv

## create known TE insertion file: chromosome, F/R, position, ID 
cut -d " " -f 1,3 transposonHeaders.lst | sed s/\>// | sed s/loc\=// | sed s/\;// | sed s/\:/\ / | sed s/[.][.]/\ / | sed s/complement\(// | sed s/\)// > table3.csv

awk '{print $2,"R",$4,$1}' table3.csv | tr " " "\t" > tableR.csv

awk '{print $2,"F",$3,$1}' table3.csv | tr " " "\t" > tableF.csv

# create final table
cat tableF.csv tableR.csv | sort -k 4 > TEknown5.51.tsv

#clean up
rm table*.csv header transposonHeaders.lst transposonLong5.51.fasta