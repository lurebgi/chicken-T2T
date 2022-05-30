#!/bin/bash

#SBATCH --job-name=augustus
#SBATCH -N 1
#SBATCH --mem=5000
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks-per-core=1
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=maker-%j.out
#SBATCH --error=maker-%j.err

chr=$1
module load augustus

#unset  AUGUSTUS_CONFIG_PATH
#export AUGUSTUS_CONFIG_PATH=/scratch/luohao/Fish/annotation/augustus/config

chr=$(sed -n ${SLURM_ARRAY_TASK_ID}p chr.list)
mkdir chr.out

augustus --species=chicken --UTR=off   --genemodel=complete --outfile=$TMPDIR/$chr.augustus chr/$chr.fa
mv $TMPDIR/$chr.augustus* chr.out/

les chr.list  | while read line; do perl /scratch/luohao/software/EVidenceModeler-1.1.1//EvmUtils/misc/augustus_GTF_to_EVM_GFF3.pl chr.out/$line.augustus;done > all.gff3
