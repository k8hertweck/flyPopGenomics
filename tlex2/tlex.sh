#!/bin/bash
#$ -S /bin/bash -cwd
#$ -o flytest.out -j y
#$ -l highprio
#$ -N flytest
#$ -M k8hertweck@gmail.com
#$ -m e

cd /home/nescent/kh200/fly

perl tlex-open-v2.2.1.pl -pairends yes -noclean -T annotations.lst -M 	TEcopies_R542_5425TEs_108TEreannotated_map_strand -G ref/ref.fasta -R ACO
perl tlex-open-v2.2.1.pl -pairends yes -noclean -T annotations.lst -M 	TEcopies_R542_5425TEs_108TEreannotated_map_strand -G ref/ref.fasta -R AO
perl tlex-open-v2.2.1.pl -pairends yes -noclean -T annotations.lst -M 	TEcopies_R542_5425TEs_108TEreannotated_map_strand -G ref/ref.fasta -R B
perl tlex-open-v2.2.1.pl -pairends yes -noclean -T annotations.lst -M 	TEcopies_R542_5425TEs_108TEreannotated_map_strand -G ref/ref.fasta -R BO
perl tlex-open-v2.2.1.pl -pairends yes -noclean -T annotations.lst -M 	TEcopies_R542_5425TEs_108TEreannotated_map_strand -G ref/ref.fasta -R CO
perl tlex-open-v2.2.1.pl -pairends yes -noclean -T annotations.lst -M 	TEcopies_R542_5425TEs_108TEreannotated_map_strand -G ref/ref.fasta -R NCO
