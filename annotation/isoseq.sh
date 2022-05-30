conda activate isoseq3
sample=$1
cpu=16
ccs $sample.subreads.bam $sample.ccs.bam --min-rq 0.95 -j $cpu

lima $sample.ccs.bam primers.fasta $sample.fl.bam --isoseq --peek-guess -j $cpu

isoseq3 refine $sample.fl.NEB_5p--NEB_Clontech_3p.bam primers.fasta $sample.flnc.bam -j $cpu --require-polya
#isoseq3 refine $sample.demux.primer_5p--primer_3p.bam $sample.flnc.bam -j $cpu --require-polya
isoseq3 cluster $sample.flnc.bam $sample.clustered.bam --use-qvs -j $cpu


minimap2 -t $cpu -ax splice  --secondary=no -uf ../assembly/bf.v3.fa $sample.clustered.hq.fasta.gz | sort -k3,3 -k4,4n >  $sample.clustered.hq.fasta.gz.sort.sam
gunzip $sample.clustered.hq.fasta.gz
collapse_isoforms_by_sam.py --input $sample.clustered.hq.fasta -s $sample.clustered.hq.fasta.gz.sort.sam --dun-merge-5-shorter -o $sample

get_abundance_post_collapse.py $sample.collapsed $sample.clustered.cluster_report.csv

filter_by_count.py --min_count 2 --dun_use_group_count $sample.collapsed

filter_away_subset.py $sample.collapsed.min_fl_2
