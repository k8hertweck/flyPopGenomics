#!/bin/bash
## running popoolationTE on individual pooled populations
# Usage: specify treatment (e.g., ACO) on command line as $1 in file popTEscripts, 
#	run using popTE.slurm batch script
# requires first running filePrep.sh and popTEsetup.slurm

# PopoolationTE note: comment out "if of read is supposed to end with /1 or /2 :" warning on line 310 of samro.pl or large output files will result

module load bwa/0.7.7 perl/5.16.2 samtools/1.3

popte=/work/03177/hertweck/myapps/popoolationte

cd /scratch/03177/hertweck/fly/$1

# set up for loop
for x in 1 2 3 4 5
	do
		echo $1"$x"
		if [ -f $1"$x"pe-reads.sorted.bam ]
			then
				echo "reads already mapped"
				samtools view -h --threads 2 $1"$x"pe-reads.sorted.bam > $1"$x"pe-reads.sorted.sam
			else
				# file conversion
				if [ -f $1"$x"R1.fastq ]
					then 
						echo "R1 already unzipped"
					else
						gunzip $1"$x"R1.fastq.gz 
				fi
				if [ -f $1"$x"R2.fastq ]
					then
						echo "R2 already unzipped"
					else
						gunzip $1"$x"R2.fastq.gz
				fi
				if [ -f $1"$x"R1pop.fastq ]
					then 
						echo "R1 already converted"
					else
						awk '{if ($2 ~ /^[0-9]/) print $1 "/1"; else print $0}' $1"$x"R1.fastq > $1"$x"R1pop.fastq
				fi
				if [ -f $1"$x"R2pop.fastq ]
					then 
						echo "R2 already converted"
					else
						awk '{if ($2 ~ /^[0-9]/) print $1 "/2"; else print $0}' $1"$x"R2.fastq > $1"$x"R2pop.fastq
				fi				
				
				# run bwa on each paired end file individually
				if [ -f $1"$x"R1.sam ]
					then 
						echo "R1 already mapped"
					else
						bwa bwasw -t 2 ../DmelComb.fas $1"$x"R1pop.fastq > $1"$x"R1.sam
				fi
				if [ -f $1"$x"R2.sam ]
					then 
						echo "R2 already mapped"
					else
						bwa bwasw -t 2 ../DmelComb.fas $1"$x"R2pop.fastq > $1"$x"R2.sam
				fi

				# create paired-end information
				if [ -f $1"$x"pe-reads.sam ]
					then 
						echo "mapped reads already paired"
					else
						perl $popte/samro.pl --sam1 $1"$x"R1.sam --sam2 $1"$x"R2.sam \
							--fq1 $1"$x"R1pop.fastq --fq2 $1"$x"R2pop.fastq \
							--output $1"$x"pe-reads.sam
				fi
	
				# sort mapped file and save as bam
				samtools view -b --threads 2 $1"$x"pe-reads.sam > $1"$x"pe-reads.bam
				samtools sort --threads 2 $1"$x"pe-reads.bam > $1"$x"pe-reads.sorted.bam
		fi
		
		# convert to sam
		if [ -f $1"$x"pe-reads.sorted.sam ]
			then
				echo "mapped file converted to sam"
			else
				samtools view -h --threads 2 $1"$x"pe-reads.sorted.bam > $1"$x"pe-reads.sorted.sam
		fi
	
		# clean up
        rm $1"$x"R*pop.fastq $1"$x"R*.sam $1"$x"pe-reads.bam $1"$x"pe-reads.sam
        gzip $1"$x"R*.fastq

		## run popoolationTE
		if [ -f $1"$x"te-poly-filtered.txt ]
			then
				echo "popoolationTE already run"
			else
				# identify forward and reverse insertions
				echo "identify forward and reverse insertions: identify-te-insertsites.pl"
				perl $popte/identify-te-insertsites.pl --input $1"$x"pe-reads.sorted.sam --output $1"$x"te-fwd-rev.txt --min-count 5 --narrow-range 75 --min-map-qual 20 -te-hierarchy-file ../TEhierarchy5.51.tsv --te-hierarchy-level family

				# obtain TE insertions
				echo "obtain TE insertions: crosslink-te-sites.pl"
				perl $popte/crosslink-te-sites.pl --directional-insertions $1"$x"te-fwd-rev.txt --min-dist 75 --max-dist 250 --output $1"$x"te-inserts.txt --single-site-shift 100 --poly-n ../poly_n.gtf --te-hierarchy ../TEhierarchy5.51.tsv --te-hier-level family

				# Use known TE insertions to improve crosslinking 
				perl $popte/update-teinserts-with-knowntes.pl --known ../TEknown5.51.tsv --output $1"$x"te-insertions.txt --te-hierarchy-file ../TEhierarchy5.51.tsv --te-hierarchy-level family --max-dist 250 --te-insertions $1"$x"te-inserts.txt --single-site-shift 100

				# estimate population frequencies
				echo "estimate population frequencies: estimate-polymorphism.pl"
		perl $popte/estimate-polymorphism.pl --sam-file $1"$x"pe-reads.sorted.sam --te-insert-file $1"$x"te-insertions.txt --te-hierarchy-file ../TEhierarchy5.51.tsv --te-hierarchy-level family --min-map-qual 20 --output $1"$x"te-polymorphism.txt

				# filter output
				echo "filter output: filter-teinserts.pl"
				perl $popte/filter-teinserts.pl --te-insertions $1"$x"te-polymorphism.txt --output $1"$x"te-poly-filtered.txt --discard-overlapping --min-count 5
		fi
		
		# clean up
		rm $1"$x"pe-reads.sorted.sam
done
