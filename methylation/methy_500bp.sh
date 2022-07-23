# merge methylation frequency from multiple Nanopore cells
cat *methylation_frequency.tsv   |    grep -v ^chro | awk '{a[$1"__"$2]+=$5;b[$1"__"$2]+=$6}END{for(i in a){print i"\t"a[i]"\t"b[i]}}' | sed 's/__/ /' | awk '{print $1"\t"$2"\t"$2"\t"$3"\t"$4}'  > merged.methy

# get methylation level in 500 bp windows
bedtools map -c 4,5 -o sum -a <(bedtools sort -i v22.fa.fai.500) -b merged.methy > merged.methy.sort.500-sum 
