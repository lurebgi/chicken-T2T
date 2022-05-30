#!/bin/bash

#SBATCH --job-name=maker_ck
#SBATCH --partition=basic
#SBATCH -N 1
#SBATCH --ntasks-per-node=8
#SBATCH --ntasks-per-core=1
#SBATCH --mem=9000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=maker-%j.out
#SBATCH --error=maker-%j.err


module load maker

unset  AUGUSTUS_CONFIG_PATH
export AUGUSTUS_CONFIG_PATH=/scratch/luohao/Fish/annotation/augustus/config


srun -n 24 maker -base ck  -fix_nucleotides --ignore_nfs_tmp maker_opts.ctl maker_bopts.ctl  maker_exe.ctl
