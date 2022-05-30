#!/bin/bash

#SBATCH --job-name=HiCExplorer
#SBATCH --partition=basic
#SBATCH --cpus-per-task=12
#SBATCH --mem=9000
#SBATCH --mail-type=FAIL
#SBATCH --output=HiCExplorer_Protocol_%j.sh.o
#SBATCH --error=HiCExplorer_Protocol_%j.sh.e

##Mapping the RAW files
module load hicexplorer
mkdir mapping/
cp index/* $TMPDIR
bwa mem -A 1 -B 4 -E 50 -L 0 -t 16 $TMPDIR/v22.fa /scratch/molevo/20220302_luohao/chicken/data/hic/95G_R1.fq.gz | samtools view -Shb - > $TMPDIR/ck.hic.R1.bam
bwa mem -A 1 -B 4 -E 50 -L 0 -t 16 $TMPDIR/v22.fa /scratch/molevo/20220302_luohao/chicken/data/hic/95G_R2.fq.gz | samtools view -Shb - > $TMPDIR/ck.hic.R2.bam

mv $TMPDIR/ck.hic.R1.bam $TMPDIR/ck.hic.R2.bam mapping/
samtools index -@ 16 mapping/ck.hic.R2.bam
samtools index -@ 16 mapping/ck.hic.R1.bam


#restrictionCutFile
hicFindRestSite --fasta replaced.v18.fa --searchPattern GATC -o rest_site_positions.bed

##Build Hi-C matrix
mkdir hicMatrix/
/apps/miniconda/4.8.3/envs/hicexplorer-3.7.1/bin/hicBuildMatrix --restrictionCutFile rest_site_positions.bed  --danglingSequence GATC  --samFiles mapping/ck.hic.R1.bam mapping/ck.hic.R2.bam --binSize 100000 --restrictionSequence GATC  --QCfolder hicMatrix/250kb_QC.sub --threads 16 --inputBufferSize 400000 --outFileName hicMatrix/100kb.h5


hicCorrectMatrix diagnostic_plot -m  hicMatrix/10kb.h5  -o hicMatrix/10kb.h5.png
hicCorrectMatrix diagnostic_plot -m  hicMatrix/250kb.h5  -o hicMatrix/250kb.h5.png

hicCorrectMatrix correct -m hicMatrix/10kb.h5 --filterThreshold -2.8 4.3 -o hicMatrix/10kb.corrected.h5
hicCorrectMatrix correct -m hicMatrix/250kb.h5 --filterThreshold -6.601454256360078 2.2  -o hicMatrix/250kb.corrected.h5

hicPCA --whichEigenvectors 1 2 -m hicMatrix/250kb.corrected.h5   --format bedgraph -o hicMatrix/pca1.bed hicMatrix/pca2.bed
##Merge matrix bins
hicMergeMatrixBins --matrix hicMatrix/ww_10kb.h5 --numBins 100 --outFileName hicMatrix/ww_1Mb.h5
hicMergeMatrixBins --matrix hicMatrix/ww_10kb.h5 --numBins 5 --outFileName hicMatrix/ww_50kb.h5


