library(igraph)
args <- commandArgs(trailingOnly=TRUE)
data <- read.table(args[1],header=T)
bsk.network<-graph.data.frame(data, directed=F)

E(bsk.network)$width <- E(bsk.network)$grade/10
#bsk.network <- delete_edges(bsk.network,E(bsk.network)[E(bsk.network)$width<0.5])
bsk.network <- delete_edges(bsk.network,E(bsk.network)[E(bsk.network)$width<0.1])
#bsk.network <- delete_edges(bsk.network,E(bsk.network)[E(bsk.network)$width<0.3])

V(bsk.network)$color <- c(unique(c(as.character(data$color))),rep("grey",34))
pdf(args[2],width=5,height=5)
plot(bsk.network,vertex.label.dist=0.9,layout=layout.circle, vertex.size=8,vertex.label.size=2)
dev.off()

#legend("topright",legend=c(1:20),fill=unique(as.character(data$color)))
