nanopolish index -d fastq_pass/ output.fastq

minimap2 -a -x map-ont v22.fasta output.fastq | samtools sort -T tmp -o output.sorted.bam
samtools index output.sorted.bam

nanopolish call-methylation -t 8 -r output.fastq -b output.sorted.bam -g v22.fasta  > methylation_calls.tsv

scripts/calculate_methylation_frequency.py -c 2 methylation_calls.tsv > methylation_frequency.tsv
