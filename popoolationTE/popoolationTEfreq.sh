#!/bin/bash
#
#SBATCH -J popTEfreq                 # Job name
#SBATCH -N 1                   # Total number of nodes (16 cores/node)
#SBATCH -n 16                   # Total number of tasks
#SBATCH -p normal              # Queue name
#SBATCH -o popTEfreq.o%j             # Name of stdout output file (%j expands to jobid)
#SBATCH -t 24:00:00            # Run time (hh:mm:ss)
#SBATCH --mail-user k8hertweck@gmail.com
#SBATCH --mail-type=ALL
#SBATCH -A fly
#------------------------------------------------------

module load bwa/0.7.7

popte=/work/03177/hertweck/myapps/popoolationte

cd /scratch/03177/hertweck/fly

# set up for loop
for x in 1 2 3 4 5
	do
		
		# Use known TE insertions to improve crosslinking 
		perl $popte/update-teinserts-with-knowntes.pl --known ../TEknown5.55.tsv --output $1/te-insertions$1.txt --te-hierarchy-file $scripts/TEhierarchy5.51.tsv --te-hierarchy-level family --max-dist 300 --te-insertions $1/te-inserts$1.txt --single-site-shift 100

perl $popte/estimate-polymorphism.pl --sam-file $1data/$1pe-reads.sorted.sam --te-insert-file $1/te-insertions$1.txt --te-hierarchy-file $scripts/TEhierarchy5.51.tsv --te-hierarchy-level family --min-map-qual 15 --output $1/te-polymorphism$1.txt

perl $popte/filter-teinserts.pl --te-insertions $1/te-polymorphism$1.txt --output $1/te-poly-filtered$1.txt --discard-overlapping --min-count 10

grep -v 'if of read is supposed to end with /1 or /2' popoolationACO.out > $1/popoolation.out

tar -cvzf $1popoolation.tar.gz $1/
