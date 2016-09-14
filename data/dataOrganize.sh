#!/bin/bash

# combine and organize data from Drosophila experimental evolution (SRA SRP059073)
# usage: dataOrganize.sh population number first_accession second_accession

DATA=/scratch/03177/hertweck/fly

cd $DATA

cat $3_1.fastq.gz $4_1.fastq.gz > $1/"$1""$2"R1.fastq.gz
cat $3_2.fastq.gz $4_2.fastq.gz > $1/"$1""$2"R2.fastq.gz
