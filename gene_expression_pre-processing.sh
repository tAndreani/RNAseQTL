#Cluster is LSF IBM

#BSUB -L /bin/bash
#BSUB -o htseq-count.log
#BSUB -e htseq-count.err
#BSUB -q normal
#BSUB -J myjob[1-78]
#BSUB -M 8000000
#BSUB -u tommaso.andreani@epfl.ch
#BSUB -N


##Quality control of the read is performed using Fast-QC
export fastq_file=`sed -n "$LSB_JOBINDEX"p myjob.lsf.input`
echo fastqc -o outputdirectory/$fastqc/ -f inputdirectory/$fastqc/
fastqc -o outputdirectory/$fastqc/ -f inputdirectory/$fastqc/

# RNA-seq alignment to drosophila reference genome with Tophat2/Bowtie
export fastq_file=`sed -n "$LSB_JOBINDEX"p myjob.lsf.input`
echo tophat -p 4 -G mydirectory/data/genome/Drosophila_melanogaster/Ensembl/BDGP5/Annotation/Genes/genes.gtf -o mydirectory/alignments/$fastq_file mydirectory/data/genome/Drosophila_melanogaster/Ensembl/BDGP5/Sequence/Bowtie2Index/genome mydirectory/data/fastq/$fastq_file.fastq.gz
tophat -p 4 -G mydirectory/data/genome/Drosophila_melanogaster/Ensembl/BDGP5/Annotation/Genes/genes.gtf -o mydirectory/alignments/$fastq_file mydirectory/data/genome/Drosophila_melanogaster/Ensembl/BDGP5/Sequence/Bowtie2Index/genome mydirectory/data/fastq/$fastq_file.fastq.gz


#From BAM to SAM
export samtools_FILE=`sed -n "$LSB_JOBINDEX"p myjob.lsf.input`
echo samtools view mydirectory/data/alignments/$samtools_input/merged.srt.q10.bam > mydirectory/data/alignments/$samtools_input/merged.srt.q10.sam
samtools view mydirectory/data/alignments/$samtools_input/merged.srt.q10.bam > mydirectory/data/alignments/$samtools_input/merged.srt.q10.sam

#Quantification with htseq-count
export htseq_input=`sed -n "$LSB_JOBINDEX"p myjob.lsf.input`
echo htseq-count -m union -s no -a 10 -t exon -i gene_id mydirectory/alignments/$htseq_input/merged.srt.q10.sam  mydirectory/genome/Drosophila_melanogaster/Ensembl/BDGP5/Annotation/Genes/genes.gtf > mydirectory/data/alignments/$htseq_input/samout.gene.txt
htseq-count -m union -s no -a 10 -t exon -i gene_id mydirectory/data/alignments/$htseq_input/merged.srt.q10.sam  mydirectory/data/genome/Drosophila_melanogaster/Ensembl/BDGP5/Annotation/Genes/genes.gtf > mydirectory/data/alignments/$htseq_input/samout.gene.txt
