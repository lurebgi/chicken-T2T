#!/bin/bash

#SBATCH --job-name=minimap2
#SBATCH --partition=basic
#SBATCH --cpus-per-task=28
#SBATCH --mem=6000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=nuc-%j.out
#SBATCH --error=nuc-%j.err

REF=$1
reads=$2

cpu=18
#samtools fadx $REF
echo Minimap2


/scratch/luohao/software/Winnowmap/bin/meryl count k=15 output merylDB $REF
/scratch/luohao/software/Winnowmap/bin/meryl print greater-than distinct=0.9998 merylDB > repetitive_k15.txt

/scratch/molevo/luohao/software/Winnowmap/bin/winnowmap -t 28 -W repetitive_k15.txt -ax map-ont --secondary=no $REF <(zcat ../ultralong.100k/50-100_polish2/*gz) | samtools sort - -@ 22 -O BAM -o $TMPDIR/$REF.$reads.k15.bam

/scratch/molevo/luohao/software/Winnowmap/bin/winnowmap -t 28 -W repetitive_k15.txt -ax map-pb --secondary=no $REF <(zcat  /scratch/molevo/20220302_luohao/chicken/data/ccs_2cell/*.fasta.gz) | samtools sort - -@ 22 -O BAM -o $TMPDIR/$REF.$reads.k15.bam
