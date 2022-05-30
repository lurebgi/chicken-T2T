cat annotation/repeat/trf/trf.sh
#!/bin/bash

#SBATCH --job-name=trf
#SBATCH --partition=basic
#SBATCH --cpus-per-task=1
#SBATCH --mem=18000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=nucmer-%j.out
#SBATCH --error=nucmer-%j.err

/scratch/luohao/software/trf409.linux64 /scratch/luohao/chicken/assembly/ultralong/purge/female.contig  2 7 7 80 10 20 2000  -d -l 6

xvfb-run python3 /scratch/luohao/software/pyTanFinder/pyTanFinder.py /scratch/luohao/chicken/assembly/ultralong/purge/female.contig  -minM 10 -maxM 2000 -minMN 10 -minA 500 -px chicken    -tp /scratch/luohao/software/trf409.linux64 -bp  /apps/ncbiblastplus/2.8.1/bin/blastn -mp /apps/ncbiblastplus/2.8.1/bin/makeblastdb --no_runTRF
