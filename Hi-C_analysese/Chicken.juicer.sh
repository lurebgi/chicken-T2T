#!/bin/bash

#SBATCH --job-name=Chicken.juicer
#SBATCH --partition=basic
#SBATCH --cpus-per-task=16
#SBATCH --mem=200000
#SBATCH --mail-type=ALL
#SBATCH --output=Chicken.juicer.o
#SBATCH --error=Chicken.juicer.e

module load bwa
module load samtools

/scratch/LiuJing/Luohao/Chicken/Juicer/Muscle/scripts/juicer.sh -g Chicken -s MboI -d /scratch/LiuJing/Luohao/Chicken/Juicer -p /scratch/LiuJing/Luohao/Chicken/Reference/Chicken.chrom.sizes -y /scratch/LiuJing/Luohao/Chicken/Reference/Chicken_MboI.txt -z /scratch/LiuJing/Luohao/Chicken/Reference/Chicken.fa -D /scratch/LiuJing/Luohao/Chicken/Juicer -f -t 16

mv ./aligned/merged_nodups.txt ./Chicken.merged_nodups.txt
mv ./aligned/*.hic ./
rm -r ./aligned ./splits

java -jar /home/user/liu/Software/juicer-master/juicer_tools_1.19.02.jar pre -f ../Reference/Chicken_MboI.txt ./Chicken.merged_nodups.txt Chicken.inter_0.hic /scratch/LiuJing/Luohao/Chicken/Reference/Chicken.chrom.sizes -r 5000,10000,20000,40000,100000,500000,1000000,2000000 -k KR

gzip Chicken.merged_nodups.txt
