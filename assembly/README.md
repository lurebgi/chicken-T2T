Assemble the primary contigs using ONT ultralong reads
```
nextDenovo run.cfg
nextPolish polish.cfg

```

Assemble the primary contigs using HiFi reasds
```
sh hifiasm.sh
```
Partition the parental ONT reads using the triocanu pipeline
```
sh trio_canu.sh
```
Assemble and polish the haploid genomes with partitioned ONT ultralong reads
```
nextDenovo female.cfg
nextDenovo male.cfg
nextPolish polish.female.cfg
nextPolish polish.male.cfg
```
Assemble the haploid-resolved contigs with hifiasm using trio data
```
sh trio_hifiasm.sh
```
