#!/bin/bash
#
#SBATCH -J popTEsetup                 # Job name
#SBATCH -N 1                   # Total number of nodes (16 cores/node)
#SBATCH -n 16                   # Total number of tasks
#SBATCH -p normal              # Queue name
#SBATCH -o popTE.o%j             # Name of stdout output file (%j expands to jobid)
#SBATCH -t 24:00:00            # Run time (hh:mm:ss)
#SBATCH --mail-user k8hertweck@gmail.com
#SBATCH --mail-type=ALL
#SBATCH -A flyTE
#------------------------------------------------------

module load bwa/0.7.7 perl/5.16.2

popte=/work/03177/hertweck/myapps/popoolationte
scripts=/home1/03177/hertweck/fly/flyPopGenomics/popoolationTE

cd /scratch/03177/hertweck/fly

# copy files over from scripts folder
cp $scripts/DmelComb.fas .
cp $scripts/TEhierarchy5.51.tsv .
cp $scripts/TEknown5.51.tsv .

# index combined reference
bwa index DmelComb.fas

# identify poly-N stretches in repeat-masked genom
perl $popte/genomic-N-2gtf.pl --input DmelComb.fas > poly_n.gtf
