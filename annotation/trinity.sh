#!/bin/bash

#SBATCH --job-name=Trinity
#SBATCH --partition=himem
#SBATCH --cpus-per-task=12
#SBATCH --mem=500000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=nucmer-%j.out
#SBATCH --error=nucmer-%j.err

module unload python2
module unload java
module load trinityrnaseq


Trinity --workdir $TMPDIR/trinity --max_memory 500G --seqType fq  --output $TMPDIR/$sample.trinity.out  --CPU 12 --verbose   --min_glue 10 --path_reinforcement_distance 30  --min_contig_length 400 \
 --left /proj/luohao/chicken/data/RNA-seq.shortRead/ckB1/11.59G/R2101375A_1.fq.gz,/proj/luohao/chicken/data/RNA-seq.shortRead/ckH1/11.76G/R2101376A_1.fq.gz,/proj/luohao/chicken/data/RNA-seq.shortRead/ckL1/10.76G/R2101379A_1.fq.gz,/proj/luohao/chicken/data/RNA-seq.shortRead/ckM1/11.85G/R2101378A_1.fq.gz,/proj/luohao/chicken/data/RNA-seq.shortRead/ckS1/11.27G/R2101377A_1.fq.gz \
 --right /proj/luohao/chicken/data/RNA-seq.shortRead/ckB1/11.59G/R2101375A_2.fq.gz,/proj/luohao/chicken/data/RNA-seq.shortRead/ckH1/11.76G/R2101376A_2.fq.gz,/proj/luohao/chicken/data/RNA-seq.shortRead/ckL1/10.76G/R2101379A_2.fq.gz,/proj/luohao/chicken/data/RNA-seq.shortRead/ckM1/11.85G/R2101378A_2.fq.gz,/proj/luohao/chicken/data/RNA-seq.shortRead/ckS1/11.27G/R2101377A_2.fq.gz \
 --trimmomatic

mv $TMPDIR/$sample.trinity.out/*fasta Trinity.fasta
