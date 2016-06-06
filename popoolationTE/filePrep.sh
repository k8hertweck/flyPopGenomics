#!/bin/bash

## prepping input files for popoolationTE

## required:
# annotation version 2013 May (FB2013_03 Dmel Release 5.51) downloaded from http://flybase.org/static_pages/downloads/bulkdata7.html
#	dmel-all-transposon-r5.51.fasta.gz
# 	dmelR5.fasta (only chromosomes)
# dependencies
#	repeatmasker 4.0.5
 
## creating combined reference genome

# mask reference fasta file for Dmel genome
repeatmasker -no_is -nolow -norna -lib te-sequences.fasta ../relocate/DmelR5.fas

# filter TE sequences that are too short

# combine reference genome and TE sequences
cat reference-genome.fasta.masked te-sequences.fasta > DmelComb.fas

## TE hierarchy file from headers of dmel-all-transposon-r5.55.fasta
# insert	id	family	superfamily	suborder	class	problem


