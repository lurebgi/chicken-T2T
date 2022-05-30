#!/bin/bash

#SBATCH --job-name=hisat2
#SBATCH --partition=basic
#SBATCH --cpus-per-task=8
#SBATCH --mem=8000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=hisat2-%j.out
#SBATCH --error=hisat2-%j.err

module load hisat2
ref=v22.fa
read1=$2
read2=$3
sample=$4

hisat2-build $ref $ref
cp $ref* $TMPDIR/

hisat2 -x $TMPDIR/$ref -p 16 -5 5 -3 5 \
 -1 /scratch/molevo/20220302_luohao/chicken/data/RNA-seq/ERR753941_1.fastq.gz,/scratch/molevo/20220302_luohao/chicken/data/RNA-seq/ERR753945_1.fastq.gz,/scratch/molevo/20220302_luohao/chicken/data/RNA-seq/ERR753952_1.fastq.gz,/scratch/molevo/20220302_luohao/chicken/data/RNA-seq/ERR753994_1.fastq.gz,/scratch/molevo/20220302_luohao/chicken/data/RNA-seq/ERR753983_1.fastq.gz,/scratch/molevo/20220302_luohao/chicken/data/RNA-seq.shortRead/ckB1/11.59G/R2101375A_1.fq.gz,/scratch/molevo/20220302_luohao/chicken/data/RNA-seq.shortRead/ckH1/11.76G/R2101376A_1.fq.gz,/scratch/molevo/20220302_luohao/chicken/data/RNA-seq.shortRead/ckL1/10.76G/R2101379A_1.fq.gz,/scratch/molevo/20220302_luohao/chicken/data/RNA-seq.shortRead/ckM1/11.85G/R2101378A_1.fq.gz,/scratch/molevo/20220302_luohao/chicken/data/RNA-seq.shortRead/ckS1/11.27G/R2101377A_1.fq.gz \
 -2 /scratch/molevo/20220302_luohao/chicken/data/RNA-seq/ERR753941_2.fastq.gz,/scratch/molevo/20220302_luohao/chicken/data/RNA-seq/ERR753945_2.fastq.gz,/scratch/molevo/20220302_luohao/chicken/data/RNA-seq/ERR753952_2.fastq.gz,/scratch/molevo/20220302_luohao/chicken/data/RNA-seq/ERR753994_2.fastq.gz,/scratch/molevo/20220302_luohao/chicken/data/RNA-seq/ERR753983_2.fastq.gz,/scratch/molevo/20220302_luohao/chicken/data/RNA-seq.shortRead/ckB1/11.59G/R2101375A_2.fq.gz,/scratch/molevo/20220302_luohao/chicken/data/RNA-seq.shortRead/ckH1/11.76G/R2101376A_2.fq.gz,/scratch/molevo/20220302_luohao/chicken/data/RNA-seq.shortRead/ckL1/10.76G/R2101379A_2.fq.gz,/scratch/molevo/20220302_luohao/chicken/data/RNA-seq.shortRead/ckM1/11.85G/R2101378A_2.fq.gz,/scratch/molevo/20220302_luohao/chicken/data/RNA-seq.shortRead/ckS1/11.27G/R2101377A_2.fq.gz \
 -S $TMPDIR/temp.sam -k 4 --max-intronlen 100000 --min-intronlen 30

samtools sort $TMPDIR/temp.sam   -@ 16 -O BAM -o $TMPDIR/$sample.bam
mv $TMPDIR/$sample.bam .
samtools index -@ 8 $sample.bam
