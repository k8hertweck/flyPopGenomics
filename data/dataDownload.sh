#!/bin/bash

# download and extract raw data for Drosophila experimental evolution (SRA SRP059073)
# usage: dataDownload.sh SRA_accession

module load sratoolkit/2.5.5
DATA=/scratch/03177/hertweck/fly

cd $DATA

# extract fastq from SRA as separate paired-end files
fastq-dump --split-files --gzip $1
