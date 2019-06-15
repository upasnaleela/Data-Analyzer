#PIE
slices<-c(sum(table_final$positive),sum(table_final$negative))
labels<-c("positive","Negative")
library(plotrix)

pie3D(slices,labels=labels,col=rainbow(length(labels)),explode=0.00,main="sentiment Analysis")
