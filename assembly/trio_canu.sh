#!/bin/bash

#SBATCH --job-name=canu
#SBATCH --partition=basic
#SBATCH --cpus-per-task=1
#SBATCH --mem=15000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=run-%j.out
#SBATCH --error=run-%j.err


/scratch/luohao/software/canu-2.1/bin/canu -p asm -d trio.100k genomeSize=1g  \
-haplotypeF /proj/luohao/chicken/data/parental/201116_SEQ105_DP8400014279BR_L01_SP2011030002.female/DP8400014279BR_L01_503_*.fq.gz  \
-haplotypeM /proj/luohao/chicken/data/parental/201120_SEQ101_DP8400014285BL_L01_SP2011030001.male/DP8400014285BL_L01_502_*.fq.gz \
-nanopore /proj/luohao/chicken/data/nanopore/raw_data_2021-07-15/genome/Nanopore/H3/*/*/qc_report/fastq/*pass.fastq.gz  \
 maxMemory=1800G maxThreads=12 ovlThreads=12 hapMemory=100G hapThreads=8  \
 gridOptions="--partition=basic " useGrid=True
