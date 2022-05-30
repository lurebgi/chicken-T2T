cat chipseq_map_bowtie2.sh
#!/bin/bash

#SBATCH --job-name=chipseq
#SBATCH --partition=basic
#SBATCH --cpus-per-task=12
#SBATCH --mem=24000
#SBATCH --mail-type=FAIL
#SBATCH --output=depth-%j.out
#SBATCH --error=depth-%j.err

module load samtools
module load bowtie2
module load bedtools

genome0=$1
chip=$2
sra=$3
size=$chip
dir=`pwd`
win=100k

genome=$(echo ${genome0##*/})
bwa index /scratch/luohao/chicken/assembly/hic_juicer/v22.fa -p index/ck

mkdir $chip
cp index/ck.* $TMPDIR

bwa mem -t 12  -k 50 -c 1000000 $TMPDIR/ck <(zcat /scratch/molevo/20220302_luohao/chicken/data/chipseq/${sra}_1.fastq.gz) <(zcat /scratch/molevo/20220302_luohao/chicken/data/chipseq/${sra}_2.fastq.gz) |  samtools sort -@ 8 -o $chip/$genome.$size.bwa.bam  - -O BAM

/apps/quast/5.0.2/lib/python3.7/site-packages/quast-5.0.2-py3.7.egg/quast_libs/sambamba/sambamba_linux markdup --overflow-list-size 600000  --tmpdir=$TMPDIR -r $chip/$genome.$size.bwa.bam $chip/$genome.$size.bwa.rmdup.bam

samtools view -@ 12 -q 30 -F 2308 $chip/$genome.$size.bwa.rmdup.bam -O BAM -o $chip/$genome.$size.bwa.rmdup.2308.bam

bedtools genomecov -ibam $chip/$genome.$size.bwa.rmdup.2308.bam -d |  awk '{print $1"\t"$2-1"\t"$2"\t"$3}' | bedtools map -c 4 -o sum -b - -a /scratch/molevo/luohao/chicken/assembly/hic_juicer/v22.fa.g.10k > $chip/$genome.$size.bwa.rmdup.2308.bam.10k
