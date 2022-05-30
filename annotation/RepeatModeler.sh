#!/bin/bash

#SBATCH --job-name=repMod
#SBATCH --partition=basic
#SBATCH --cpus-per-task=12
#SBATCH --mem=300
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=nucmer-%j.out
#SBATCH --error=nucmer-%j.err

spe=$1

/apps/repeatmodeler/2.0/BuildDatabase -name $spe.repeat_modeler -dir ./ $spe.fa
/apps/repeatmodeler/2.0/RepeatModeler -database $spe.repeat_modeler -pa 8
