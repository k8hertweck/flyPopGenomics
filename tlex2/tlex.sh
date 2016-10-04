#!/bin/bash
#$ -S /bin/bash -cwd
#$ -o flytest.out -j y
#$ -l highprio
#$ -N flytest
#$ -M k8hertweck@gmail.com
#$ -m e

cd /home/nescent/kh200/fly

perl tlex-open-v2.2.1.pl -pairends yes -noclean -T annotations/list -M annotations/annotations -G ref/ref.fasta -R ACO
perl tlex-open-v2.2.1.pl -pairends yes -noclean -T annotations/list -M annotations/annotations -G ref/ref.fasta -R AO
perl tlex-open-v2.2.1.pl -pairends yes -noclean -T annotations/list -M annotations/annotations -G ref/ref.fasta -R B
perl tlex-open-v2.2.1.pl -pairends yes -noclean -T annotations/list -M annotations/annotations -G ref/ref.fasta -R BO
perl tlex-open-v2.2.1.pl -pairends yes -noclean -T annotations/list -M annotations/annotations -G ref/ref.fasta -R CO
perl tlex-open-v2.2.1.pl -pairends yes -noclean -T annotations/list -M annotations/annotations -G ref/ref.fasta -R NCO
