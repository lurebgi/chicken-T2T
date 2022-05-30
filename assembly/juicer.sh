#!/bin/bash

#SBATCH --job-name=juicer
#SBATCH --partition=basic
#SBATCH --cpus-per-task=1
#SBATCH --mem=17800
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=canu-%j.out
#SBATCH --error=canu-%j.err

module unload java perl juicer/1.7.6
module load juicer bwa python2

spe=$1
/apps/python2/2.7.14/bin/python  /scratch/luohao/amphioxus/hic/bbbf_bb/generate_site_positions.bj.py MboI  $spe.fa $spe.fa
bwa index $spe.fa
samtools faidx $spe.fa
cut -f 1,2 $spe.fa.fai > $spe.fa.sizes
cd references/; ln -s ../$spe.fa.* .; cd -

./juicer_script.sh -t 12 -g $spe -s MboI  -D $PWD  -y $spe.fa_MboI.txt -z  $PWD/references/$spe.fa -p $spe.fa.sizes


awk -f  /scratch/luohao/software/3d-dna/utils/generate-assembly-file-from-fasta.awk $spe.fa > $spe.fa.assembly
/scratch/luohao/software/3d-dna/visualize/run-assembly-visualizer.sh  $spe.fa.assembly aligned/merged_nodups.txt
