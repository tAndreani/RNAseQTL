RNAseQTL
==================

Collection of scripts to map eQTL with RNAseq Data and Annotated Variants. To map eQTL we need two files:  

1) Gene expression counts matrix;  
2) Genotype of the animal model (0 homozygot reference, 1 hereozygote alternative, 2 homozygote alternative);    

## Summary 

RNAseQTL is a collection of scripts to map cis-eQTL. The pipeline is designed getting transcriptomic from RNA-seq data 
and variants annotation in VCF file format. 

## Requirements  

RNAseQTL requieres the following softwares:  

•	FastQC  

•	Tophat2/Bowtie2  

•	HTSeq-count  

• VCFtools  

• plink 1.9  

• R    

• BioMart   
  
• GenomicFeatures  
  
• Matrix-eQTL  
  

The pre-built indexes of the reference genome could be downloaded in ENSEMBL or in the iGenomes website (http://support.illumina.com/sequencing/sequencing_software/igenome.html).



