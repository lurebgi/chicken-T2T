cat annotation/PASA/pasa.sh
#!/bin/bash

#SBATCH --job-name=pasa
#SBATCH --partition=basic
#SBATCH --cpus-per-task=1
#SBATCH --mem=18000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=depth-%j.out
#SBATCH --error=depth-%j.err


module load sqlite3
module load gmap ucsc blat
export PATH=/scratch/luohao/software/fasta-36.3.8g/bin:$PATH


for trinity in day1_clean.sam.gtf.filt.trans.rmTE.filt day3_clean.sam.gtf.filt.trans.rmTE.filt day5_clean.sam.gtf.filt.trans.rmTE.filt day7_clean.sam.gtf.filt.trans.rmTE.filt brain_clean.sam.gtf.filt.trans.rmTE.filt B1_clean.sam.gtf.filt.trans.rmTE.filt; do
gff=$(ls -ltr *gff3 | awk '{print $NF}' | tail -1)

rm -fr __* ck.sqlite pasa_run.log.dir *log *checkpoints* *transdecoder*

/scratch/luohao/software/PASApipeline.v2.4.1/bin/seqclean $trinity
minimap2 -t 2 -ax splice --secondary=no --cs ../../assembly/consensus_hap/replaced.v18.fa  $trinity  | samtools view -h -q 30 |  samtools sort -@ 12 -o $trinity.sam - -O SAM
perl /scratch/luohao/software/PASApipeline.v2.4.1/misc_utilities/SAM_to_gtf.pl $trinity.sam > $trinity.sam.gff3
/scratch/luohao/software/PASApipeline.v2.4.1//Launch_PASA_pipeline.pl -c alignAssembly.conf -C -R -g ../../assembly/consensus_hap/replaced.v18.fa  -t $trinity.clean  -T -u $trinity --IMPORT_CUSTOM_ALIGNMENTS_GFF3 $trinity.sam.gff3 --CPU 1 --PASACONF conf.txt  --TRANSDECODER


cp ck.sqlite alignAssembly.conf annotationCompare.conf  $TMPDIR
sed -i "s#/scratch/luohao/chicken/annotation/PASA#$TMPDIR#" $TMPDIR/alignAssembly.conf
sed -i "s#/scratch/luohao/chicken/annotation/PASA#$TMPDIR#" $TMPDIR/annotationCompare.conf

/scratch/luohao/software/PASApipeline.v2.4.1/scripts/Load_Current_Gene_Annotations.dbi -c $TMPDIR/alignAssembly.conf -g ../../assembly/consensus_hap/replaced.v18.fa -P $gff

/scratch/luohao/software/PASApipeline.v2.4.1/Launch_PASA_pipeline.pl -c $TMPDIR/annotationCompare.conf -A -g ../../assembly/consensus_hap/replaced.v18.fa  --CPU 1 --PASACONF conf.txt --stringent_alignment_overlap 30 --gene_overlap 30 -t  $trinity.clean

done
