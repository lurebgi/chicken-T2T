#!/bin/bash

#SBATCH --job-name=stain
#SBATCH --partition=basic
#SBATCH --cpus-per-task=8
#SBATCH --mem=6000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=nuc-%j.out
#SBATCH --error=nuc-%j.err

chr=$1
module unload python2
module load python2/2.7.14


samtools faidx v22.fa $chr:0-900000 > $chr/$chr.fa
samtools faidx $chr/$chr.fa

snakemake --cores 8 --config sample=$chr fasta=$chr/$chr.fa #window=900

snakemake --config sample=$chr fasta=$chr/$chr.fa --cores 8 make_figures
