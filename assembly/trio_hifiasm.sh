#!/bin/bash

#SBATCH --job-name=hifi-trio
#SBATCH --partition=basic
#SBATCH --cpus-per-task=12
#SBATCH --mem=15000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=flye-%j.out
#SBATCH --error=flye-%j.err


/scratch/luohao/software/yak/yak count -b37 -t32 -o pat.yak <(zcat /proj/luohao/chicken/data/201116_SEQ105_DP8400014279BR_L01_SP2011030002/DP8400014279BR_L01_503_1.fq.gz /proj/luohao/chicken/data/201116_SEQ105_DP8400014279BR_L01_SP2011030002/DP8400014279BR_L01_503_2.fq.gz) <(zcat /proj/luohao/chicken/data/201116_SEQ105_DP8400014279BR_L01_SP2011030002/DP8400014279BR_L01_503_1.fq.gz /proj/luohao/chicken/data/201116_SEQ105_DP8400014279BR_L01_SP2011030002/DP8400014279BR_L01_503_2.fq.gz)

/scratch/luohao/software/yak/yak count -b37 -t32 -o mat.yak <(zcat /proj/luohao/chicken/data/201120_SEQ101_DP8400014285BL_L01_SP2011030001/DP8400014285BL_L01_502_1.fq.gz /proj/luohao/chicken/data/201120_SEQ101_DP8400014285BL_L01_SP2011030001/DP8400014285BL_L01_502_2.fq.gz) <(zcat /proj/luohao/chicken/data/201120_SEQ101_DP8400014285BL_L01_SP2011030001/DP8400014285BL_L01_502_1.fq.gz /proj/luohao/chicken/data/201120_SEQ101_DP8400014285BL_L01_SP2011030001/DP8400014285BL_L01_502_2.fq.gz)

/scratch/luohao/software/hifiasm/hifiasm -o 3cell.trio -t12  -1 pat.yak -2 mat.yak  /proj/luohao/chicken/data/ccs_2cell/*fasta /proj/luohao/chicken/data/ccs_2cell/*fasta.gz
