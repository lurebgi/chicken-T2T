#!/bin/bash

#SBATCH --job-name=bwa
#SBATCH --partition=basic
#SBATCH --cpus-per-task=20
#SBATCH --mem=9800
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=depth-%j.out
#SBATCH --error=depth-%j.err

module load bwa

genome=v22.fa
mkdir index
bwa index $genome -p index/$genome
cp index/* $TMPDIR/

size=mat
bwa mem -t 16  $TMPDIR/$genome <(zcat /proj/luohao/chicken/data/parental/201116_SEQ105_DP8400014279BR_L01_SP2011030002.female/DP8400014279BR_L01_503_1.fq.gz | cat - /proj/luohao/chicken/data/parental/SRR13528219_1.fastq)  <(zcat /proj/luohao/chicken/data/parental/201116_SEQ105_DP8400014279BR_L01_SP2011030002.female/DP8400014279BR_L01_503_2.fq.gz | cat - /proj/luohao/chicken/data/parental/SRR13528219_2.fastq)   |  samtools sort -@ 24 -O BAM -o $TMPDIR/$genome.mat.sorted.bam  -
samtools index -@ 20 $TMPDIR/$genome.mat.sorted.bam
mv $TMPDIR/$genome.$size.sorted.bam $TMPDIR/$genome.$size.sorted.bam.bai .

size=pat
bwa mem -t 24  $TMPDIR/$genome  /scratch/molevo/20220302_luohao/chicken/data/parental/201120_SEQ101_DP8400014285BL_L01_SP2011030001.male/DP8400014285BL_L01_502_1.fq.gz  /scratch/molevo/20220302_luohao/chicken/data/parental/201120_SEQ101_DP8400014285BL_L01_SP2011030001.male/DP8400014285BL_L01_502_2.fq.gz   |  samtools sort -@ 24 -O BAM -o $TMPDIR/$genome.pat.sorted.bam  -
samtools index -@ 24 $TMPDIR/$genome.pat.sorted.bam
mv $TMPDIR/$genome.$size.sorted.bam $TMPDIR/$genome.$size.sorted.bam.bai .
