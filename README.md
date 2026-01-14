Note: some codes were adopted according to the configuration environment of the Life Science Server of University of Vienna.

## Description for each directory:
- The [assembly] directory contains codes for trio binning, haploid genome assembly. The (pseudo)commands for executing assembly and polishing are also shwon in the directory.

- The [annotation] directory contains codes for repeat annotations, transcriptome assembly (Trinity), gene model training, full-length RNA sequencing data processing, BUSCO evaluation, gene model predictions (MAKER), gene model polishing (PASApipeline), etc. 

- The [Hi-C_analysese] directory contains codes for Hi-C scaffolding, Hi-C heatmap visualization, A/B compartment calling, and Perl scripts for calculating the frequency of inter-chromosomal interactions (**Fig. 1e**). The config file for HiC-Pro is also provided.

- The [ChIP-seq] contains codes for mapping and processing ChIP-seq data, and the [methylation] contains codes for calling 5mC DNA methylation using the Nanopore long reads. 

- The [genomic_feature] direcotory contains codes for comparative genomics analyses, including calculating GC content and sequencing depth (**Fig. 1d**), whole-genome alignment, and mapping short- and long-reads against the reference.

- The [ortholog] directory contains codes for identifying orthologous groups using OrthoFinder, and an R script for ploting the igraph figures visualising the frequency of orthologous gene-pair between chicken and amphioxus chromosomes (**Fig. 2a**).

- The [centromere] directory contains codes for identify units of tandem repeat using [TideHunter], visualization tandem repeats using [StainedGlass] (**Fig. 3b-c**), and an R script for ploting the CENP-A signals and 5mC levels (**Fig. 3b-c**). ChiP-seq analysis for CENP-A is included in the ChIP-seq folder.

## Data availability
The assemblies and raw sequencing data are available under the NCBI accession [PRJNA693184].
- latest genome and annotation files:
Please download with this [link] (Dropbox) or [this] (微云)

## Centromere coordinators
Please find the file cenpa.range.all in [centromere]. The coordinators are based on GCA_024206055.1. The centromeric regions are defined by the CENP-A ChIP-seq data, such as SRA DRR018430. For the sex chromosomes:
chrW: 7030000 to 7080000
chrZ: 44130000 to 44170000





[assembly]: https://github.com/lurebgi/chicken-T2T/tree/main/assembly
[annotation]: https://github.com/lurebgi/chicken-T2T/tree/main/annotation
[Hi-C_analysese]: https://github.com/lurebgi/chicken-T2T/tree/main/Hi-C_analysese
[ChIP-seq]: https://github.com/lurebgi/chicken-T2T/tree/main/ChIP-seq
[methylation]: https://github.com/lurebgi/chicken-T2T/tree/main/methylation
[genomic_feature]: https://github.com/lurebgi/chicken-T2T/tree/main/genomic_feature
[ortholog]: https://github.com/lurebgi/chicken-T2T/tree/main/ortholog
[centromere]: https://github.com/lurebgi/chicken-T2T/tree/main/centromere
[TideHunter]: https://github.com/Xinglab/TideHunter
[StainedGlass]: https://github.com/mrvollger/StainedGlass
[PRJNA693184]: https://www.ncbi.nlm.nih.gov/bioproject/?term=PRJNA693184
[link]: https://www.dropbox.com/scl/fo/plq2tm2w9lzlk0ua1rzph/h?dl=0&rlkey=l6z3rgmjs7ec9azun8nundnzl
[this]:https://share.weiyun.com/kh6Y8CAW

