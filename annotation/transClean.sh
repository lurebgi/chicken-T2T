cat annotation/nanopore/transClean.sh
#!/bin/bash

#SBATCH --job-name=transClean
#SBATCH --partition=basic
#SBATCH --cpus-per-task=8
#SBATCH --mem=13000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=nucmer-%j.out
#SBATCH --error=nucmer-%j.err
#SBATCH --nice=5000

#conda activate isoncorrect

sample=$1
sra=$sample
cp replaced.v18.fa.splice-mmi  $TMPDIR

minimap2 -t 16 -ax splice --secondary=no --cs $TMPDIR/replaced.v18.fa <(seqkit fq2fa ck$sample.out/clustering/sorted.fastq | sed 's/_runid.*//' )  | samtools view -h -q 30 -@ 12 | samtools sort - -O SAM -o $TMPDIR/$sample.sam -@ 16

~/miniconda2/envs/isoncorrect/bin/python3.7 /scratch/luohao/software/TranscriptClean/TranscriptClean.py --sam $TMPDIR/$sample.sam --genome replaced.v18.fa -t 8 -o $sample --tmpDir=$TMPDIR --bufferSize=200

minimap2 -ax splice -t 12 -uf --secondary=no -C5 $TMPDIR/replaced.v18.fa  ${sample}_clean.fa > $TMPDIR/sam
sort -k3,3 -k4,4n $TMPDIR/sam > ${sample}_clean.sort.sam
