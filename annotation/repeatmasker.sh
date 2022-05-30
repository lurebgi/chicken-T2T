#!/bin/bash

#SBATCH --job-name=repMask
#SBATCH --partition=basic
#SBATCH --cpus-per-task=8
#SBATCH --mem=3000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=nucmer-%j.out
#SBATCH --error=nucmer-%j.err

module load repeatmasker/4.1.2
module load ncbiblastplus


spe=$1
lib=$2

mkdir $spe.${lib}_RM_output_dir

RepeatMasker   -e rmblast  -pa 8 -a -xsmall -gccalc  -frag 100000 -no_is -dir $spe.${lib}_RM_output_dir -lib chicken.lib  $spe.fa

