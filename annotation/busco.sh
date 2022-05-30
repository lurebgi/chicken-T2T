#!/usr/bin/env bash
#SBATCH --job-name=busco
#SBATCH --cpus-per-task=8
#SBATCH --mem=3G
#SBATCH --mail-type=FAIL


# Load the BUSCO module and virtual environment
#module load busco/4.0.5
spe=$1
conda activate busco405

# Configure BUSCO and AUGUSTUS,
# replace with custom paths for your project.
export BUSCO_CONFIG_FILE=/scratch/luohao/parakeet/annotation/busco/config/config.ini
export AUGUSTUS_CONFIG_PATH=/scratch/luohao/parakeet/annotation/busco/config
# Run BUSCO with custom arguments
/apps/busco/4.0.5/busco405/bin/python /apps/busco/4.0.5/busco405/bin/busco -i $spe.fa  -c 8 -o ${spe}_out -m geno -l aves --force
