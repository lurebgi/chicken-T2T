cat hifi_alone/hifiasm.sh
#!/bin/bash

#SBATCH --job-name=hifiasm
#SBATCH --partition=himem
#SBATCH --cpus-per-task=32
#SBATCH --mem=15000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=flye-%j.out
#SBATCH --error=flye-%j.err


hifiasm  -t32 /proj/luohao/chicken/data/ccs_2cell/*fasta -o 3cell
