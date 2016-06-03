# prepping input files for popoolationTE

## required:
# dmel-all-transposon-r5.55.fasta
#
 
## creating combined reference genome

# mask reference fasta file for Dmel genome
repeatmasker -no_is -nolow -norna -lib te-sequences.fasta ../relocate/DmelR5.fas

# filter TE sequences that are too short

# combine reference genome and TE sequences
cat reference-genome.fasta.masked te-sequences.fasta > DmelComb.fas

## TE hierarchy file from headers of dmel-all-transposon-r5.55.fasta
# insert	id	family	superfamily	suborder	class	problem


