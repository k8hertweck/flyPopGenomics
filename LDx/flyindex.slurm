#!/bin/bash
#----------------------------------------------------
# From example SLURM job script job.mpi
#----------------------------------------------------

#SBATCH -J index              # Job name
#SBATCH -o index.%j.out       # Name of stdout output file (%j expands to jobId)
#SBATCH -p normal	      # Queue name
#SBATCH -n 1                  # Total number of  tasks requested
#SBATCH -t 24:00:00           # Run time (hh:mm:ss) 
#SBATCH --mail-user k8hertweck@gmail.com
#SBATCH --mail-type END

#SBATCH -A flyTE	      # <-- Allocation name to charge job against

./LDindex.sh


