furry-octo-ironman
==================

A pipeline to map eQTL with RNAseq Data and Genotype by Sequencing

SUMMARY

Furry-octo-ironman is a pipeline to map cis-eQTL. The pipeline is designed getting transcriptomic from RNA-seq data 
and variants annotation in VCF file format. 

REQUIREMENTS

Furry-octo-ironman requieres the following softwares:

•	FastQC 

•	Tophat2/Bowtie2

•	HTSeq-count

• VCFtools

• plink 1.9

•	R

    o	BioMart
  
    o	GenomicFeatures
  
    o	PEER
  
    o	Matrix-eQTL
  
    o	ggplot2

Furry-octo-ironman also requires other programming languages like awk, sed, and R scripts for specific purpose like filter
the gene expression files or the VCF file. The pre-built indexes of the reference genome could be downloaded in ENSEMBL or
in the iGenomes website (http://support.illumina.com/sequencing/sequencing_software/igenome.html).



