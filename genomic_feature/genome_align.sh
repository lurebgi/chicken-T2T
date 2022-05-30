cat assembly/6a/minimap.sh
#!/bin/bash

#SBATCH --job-name=nucmer
#SBATCH --partition=basic
#SBATCH --cpus-per-task=8
#SBATCH --mem=6000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=nuc-%j.out
#SBATCH --error=nuc-%j.err

minimap2 -t 8 -x asm5 v22.fa chicken.6a.fa --secondary=no > v22.fa.6a.paf
