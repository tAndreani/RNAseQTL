#!/bin/bash 

#BSUB -L /bin/bash
#BSUB -o vcf_stat.log
#BSUB -e vcf_stat.err
#BSUB -q normal
#BSUB -J vcf_stat
#BSUB -M 8000000
#BSUB -u tommaso.andreani@epfl.ch
#BSUB -N



#Unzip the vcf file  
unzip /scratch/cluster/monthly/tandrean/eQTL/data/Genotype/78_DGRP_genotype.freeze2.vcf.zip

#filtering
./plink --allow-extra-chr --allow-no-sex --vcf /scratch/cluster/monthly/tandrean/eQTL/data/Genotype/78_DGRP_genotype.freeze2.vcf  --chr 4 X 2L 2R 3L 3R --geno 0.9 --biallelic-only strict --maf 0.05 --output-chr M  --recode vcf --out /scratch/cluster/monthly/tandrean/eQTL/data/Genotype/78_DGRP_genotype.freeze2.filter.vcf
