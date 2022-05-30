args <- commandArgs(trailingOnly=TRUE)
library(ggplot2)
library(ggpubr)
#data <- read.table("/Users/luohao/drive/research/chicken_reference/figure/centromere/500-sum.methy.all.cenpa")
#data <- read.table("/Users/luohao/drive/research/chicken_reference/figure/centromere/cenpa.range.CENPA-5mc")
data <- read.table("/Users/luohao/drive/research/chicken_reference/figure/centromere/cenpa.range.macro.CENPA-5mc")
#data <- read.table("/Users/luohao/drive/research/chicken_reference/figure/centromere/cenpa.range.dot.CENPA-5mc")
pdf(paste(args[1],".pdf",sep=""),height=4,width=7)
ggplot(data[data$V4>20 & data$V1==args[1] ,]) + geom_line(aes(x=(V2+V3)/2,y=V5,col=V6)) + facet_grid(V6 ~ V1, scales = "free") + theme_pubr() + scale_color_manual(values=c("#7063ec","#ec7063"))
dev.off()