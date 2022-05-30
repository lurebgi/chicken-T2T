#!/bin/bash

#SBATCH --job-name=Chicken.HiCPro
#SBATCH --partition=basic
#SBATCH --cpus-per-task=16
#SBATCH --mem=20000
#SBATCH --mail-type=ALL
#SBATCH --output=Chicken.HiCPro.o
#SBATCH --error=Chicken.HiCPro.e

module load hicpro/2.11.1
module load python2

HiC-Pro -i /scratch/LiuJing/Luohao/Chicken/HiCPro/rawdata/ -o /scratch/LiuJing/Luohao/Chicken/HiCPro/output -c config-hicpro.txt -s mapping -s proc_hic -s merge_persample -s build_contact_maps -s ice_norm
