#!/bin/bash

#SBATCH --job-name=tindehunter
#SBATCH --partition=basic
#SBATCH --cpus-per-task=1
#SBATCH --mem=6000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=nuc-%j.out
#SBATCH --error=nuc-%j.err

seq=$1
/scratch/luohao/software/TideHunter-v1.4.2/bin/TideHunter -f 2 -c 3 $seq | awk '$5-$4>5000 && $8>96 && $6>600' > $seq.tidehunter
