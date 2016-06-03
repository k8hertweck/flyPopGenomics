#!/bin/bash
#$ -S /bin/bash -cwd
#$ -o popoolationACO.out -j y
#$ -l highprio
#$ -N popoolACO
#$ -M k8hertweck@gmail.com
#$ -m e

cd /home/nescent/kh200/popoolation

mkdir $1/
cp popoolationACO.sh $1/

#repeatmasker -no_is -nolow -norna -lib dmel5.55TE.fas ../relocate/DmelR5.fas

#bwa index DmelComb.fas

awk '{if ($2 ~ /^[0-9]/) print $1 "/1"; else print $0}' /netscratch/kh200/ACO/$1data/$1R1.fastq > /netscratch/kh200/ACO/$1data/$1R1pop.fastq
awk '{if ($2 ~ /^[0-9]/) print $1 "/2"; else print $0}' /netscratch/kh200/ACO/$1data/$1R2.fastq > /netscratch/kh200/ACO/$1data/$1R2pop.fastq

bwa bwasw DmelComb.fas /netscratch/kh200/ACO/$1data/$1R1pop.fastq > /netscratch/kh200/ACO/$1data/$1R1.sam
bwa bwasw DmelComb.fas /netscratch/kh200/ACO/$1data/$1R2pop.fastq > /netscratch/kh200/ACO/$1data/$1R2.sam

perl /home/nescent/kh200/software/popoolationte/samro.pl --sam1 /netscratch/kh200/ACO/$1data/$1R1.sam --sam2 /netscratch/kh200/ACO/$1data/$1R2.sam --fq1 /netscratch/kh200/ACO/$1data/$1R1pop.fastq --fq2 /netscratch/kh200/ACO/$1data/$1R2pop.fastq --output /netscratch/kh200/ACO/$1data/$1pe-reads.sam

samtools view -Sb /netscratch/kh200/ACO/$1data/$1pe-reads.sam | samtools sort - /netscratch/kh200/ACO/$1data/$1pe-reads.sorted
samtools view /netscratch/kh200/ACO/$1data/$1pe-reads.sorted.bam > /netscratch/kh200/ACO/$1data/$1pe-reads.sorted.sam

perl /home/nescent/kh200/software/popoolationte/identify-te-insertsites.pl --input /netscratch/kh200/ACO/$1data/$1pe-reads.sorted.sam --te-hierarchy-file TEtaxonomy.txt --te-hierarchy-level family --narrow-range 75 --min-count 3 --min-map-qual 15 --output $1/te-fwd-rev$1.txt

#perl /home/nescent/kh200/software/popoolationte/genomic-N-2gtf.pl --input DmelComb.fas > poly_n.gtf

perl /home/nescent/kh200/software/popoolationte/crosslink-te-sites.pl --directional-insertions $1/te-fwd-rev$1.txt --min-dist 74 --max-dist 250 --output $1/te-inserts$1.txt --single-site-shift 100 --poly-n poly_n.gtf --te-hierarchy TEtaxonomy.txt --te-hier-level order

perl /home/nescent/kh200/software/popoolationte/update-teinserts-with-knowntes.pl --known te-insertions5.55.txt --output $1/te-insertions$1.txt --te-hierarchy-file TEtaxonomy.txt --te-hierarchy-level family --max-dist 300 --te-insertions $1/te-inserts$1.txt --single-site-shift 100

perl /home/nescent/kh200/software/popoolationte/estimate-polymorphism.pl --sam-file /netscratch/kh200/ACO/$1data/$1pe-reads.sorted.sam --te-insert-file $1/te-insertions$1.txt --te-hierarchy-file TEtaxonomy.txt --te-hierarchy-level family --min-map-qual 15 --output $1/te-polymorphism$1.txt

perl /home/nescent/kh200/software/popoolationte/filter-teinserts.pl --te-insertions $1/te-polymorphism$1.txt --output $1/te-poly-filtered$1.txt --discard-overlapping --min-count 10

grep -v 'if of read is supposed to end with /1 or /2' popoolationACO.out > $1/popoolation.out

rm popoolationACO.out

tar -cvzf $1popoolation.tar.gz $1/
