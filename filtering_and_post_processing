#Getting the gene expression matrix

#Create a file in which is present the same file of different folders: 
#example: I have 80 folder with the output of gene count. I need to create a file in wich are present all the files from each folder.
#in practice: folder DGRP1 , DGRP2, DGRP3 etc.. have the file samout.gene.txt and I want to create a unique file of all the files and calls it GeneExpression.txt


#######################################################
##This is the code to create the gene expression file##
#######################################################

list.files()
list.files(,pattern="DGRP")
alldirs=list.files(,pattern="DGRP")
mytable=matrix(data=NA,nrow=15687,ncol=length(alldirs))
for (i in 1:length(alldirs)){
mytable[,i]=read.table(paste(alldirs[i],"/samout.gene.txt",sep=""),sep="\t")[,2]}
mytable[1:10,]
rownames(mytable)=read.table(paste(alldirs[i],"/samout.gene.txt",sep=""),sep="\t")[,1]
colnames(mytable)=alldirs
head(mytable)
tail(mytable)
mytable.onlygenes=mytable[grep("FB",rownames(mytable)),]
tail(mytable.onlygenes)
write.table(mytable.onlygenes,"GeneExpression.txt",sep="\t",quote=FALSE,row.names=TRUE,col.names=TRUE)
q()

##################################
##Filtering Y,Hetrozygous, mtDNA##
##################################

#Input file is a gene expression matrix in .bed format

d <- read.csv("my_file.bed.csv", header = TRUE,sep=";") ##for raw counts
useRows1 <- as.character(d[,1]) %in% c("2L", "2R", "3L", "3R", "4","X") # keep only assembled chromosomes
d.filt = d[,7:ncol(d)]/d[,7:ncol(d)]
d.filt[is.na(d.filt)] <- 0
useRows2 <- rowSums(d.filt) >= round(0.9 * (ncol(d) - 6))   # keep only genes with >=1 read in >90% of the lines
dfilt <-  d[useRows1 & useRows2,]
write.table(dfilt, "my_file.filter-nonZero90.bed", sep = "\t", quote = FALSE, col.names = TRUE, row.names = FALSE)

###############################
##Script for RPKM computation##
###############################

#First Extract all the exons unique for gene and calculate the length

source("http://bioconductor.org/biocLite.R")
biocLite("GenomicFeatures")
library(GenomicFeatures)
setwd("C:/Users/utente/Desktop/quantification/RPKM")
txdb <- makeTranscriptDbFromGFF("genes.gtf",format="gtf")
exons.list.per.gene <- exonsBy(txdb,by="gene")
head(exons.list.per.gene)
exonic.gene.sizes <- lapply(exons.list.per.gene,function(x){sum(width(reduce(x)))})
head(exonic.gene.sizes)
transpose.exonic.gene.size <- as.data.frame(exonic.gene.size)
transpose.exonic.gene.size <- t(transpose.exonic.gene.size)
write.table(transpose.exonic.gene.size,file="Exon.Length.Unique.txt",quote=F)

#Create a csv file with the reads count for each line and add the exon length in the second column
##Import the csv file and compute the RPKM value

data = read.csv("Input.RPKM.PCA.csv", sep = ";")
data = data[,-ncol(data)]
len = data[,2]
counts = data[,-c(1:2)]
head(counts)
tail(counts)
totalCounts = colSums(counts)
rpm = counts;
for(i in 1:ncol(counts)) {rpm[,i] = 1e6*counts[,i]/totalCounts[i]}
head(rpm)
rpkm = apply(rpm, 2, function(x) 1000*x/len)
head(rpkm)
