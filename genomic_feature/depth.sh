cat assembly/hic_juicer/depth.sh
#!/bin/bash

#SBATCH --job-name=minimap2
#SBATCH --partition=basic
#SBATCH --cpus-per-task=2
#SBATCH --mem=6000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=nuc-%j.out
#SBATCH --error=nuc-%j.err


samtools depth -m 200 -Q 60 v22.fa.ont.k15.bam | awk '{print $1"\t"$2-1"\t"$2"\t"$3}'  | bedtools map -a v22.fa.fai.g.50k   -b - -c 4 -o median,mean,count  > v22.fa.ont.k15.bam.50k

samtools depth -m 200 -Q 60 v22.fa.hifi.k15.bam | awk '{print $1"\t"$2-1"\t"$2"\t"$3}'  | bedtools map -a v22.fa.fai.g.50k   -b - -c 4 -o median,mean,count  > v22.fa.hifi.k15.bam.50k

samtools depth -m 200 -Q 60 v22.fa.mat.sorted.bam | awk '{print $1"\t"$2-1"\t"$2"\t"$3}'  | bedtools map -a v22.fa.fai.g.50k   -b - -c 4 -o median,mean,count  > v22.fa.mat.sorted.bam.50k
samtools depth -m 200 -Q 60 v22.fa.pat.sorted.bam | awk '{print $1"\t"$2-1"\t"$2"\t"$3}'  | bedtools map -a v22.fa.fai.g.50k   -b - -c 4 -o median,mean,count  > v22.fa.pat.sorted.bam.50k
