#!/bin/bash

## make a directory to store all your kneaded files
mkdir knead_out

##---------
## loop through each pair of reads matched by R1 and R2
##---------
for f1 in *_R1_001.fastq
do
    
    ## match forward read to reverse read
    f2=${f1%%_R1_001.fastq}"_R2_001.fastq"
    
    ## temp name
	tempname=`echo $f1 | awk -F_ '{print $1 FS $2}'`

	## kneaddata command
	kneaddata --input $f1 --input $f2 --reference-db ../../../shared/Homo_sapiens_Bowtie2_v0.1/ --output ./knead_out/$tempname -t 28

	## delete junk
	mv ./knead_out/$tempname/*_paired_1* ./knead_out/
	mv ./knead_out/$tempname/*_paired_2* ./knead_out/
    rm -rf ./knead_out/$tempname
    
done

##---------
## now that files are clean, perform the co-assembly
##---------
## get forward and reverese reads
R1s=`ls ./knead_out/*_paired_1* | python -c 'import sys; print ",".join([x.strip() for x in sys.stdin.readlines()])'`
R2s=`ls ./knead_out/*_paired_2* | python -c 'import sys; print ",".join([x.strip() for x in sys.stdin.readlines()])'`

## co-assembly
megahit -1 $R1s -2 $R2s -o ./knead_out/megahit_out --min-contig-len 2000 --kmin-1pass -t 28 --k-list 43,49,69,89,109,129 --min-count 3 --verbose --continue
