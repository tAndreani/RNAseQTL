#extract the DGRP line of interest
#inclusion is a file with the a list with your sample id to extract

zcat /scratch/cluster/monthly/tandrean/eQTL/data/Genotype/78_DGRP_genotype.freeze2.filter.vcf | vcf-subset -c inclusion.txt > /scratch/cluster/monthly/tandrean/eQTL/data/Genotype/39_DGRP_genotype.freeze2.filter.vcf

#sort before to start the manipulation
cat /scratch/cluster/monthly/tandrean/eQTL/data/Genotype/39_DGRP_genotype.freeze2.filter.vcf | vcf-sort  >  /scratch/cluster/monthly/tandrean/eQTL/data/Genotype/39_DGRP_genotype.freeze2.filter.sort.vcf

cat 39_DGRP_genotype.freeze2.filter.sort.vcf | cut -f1,2,4,5,10- > tmp1

cat tmp1 | sed '/##/d' > tmp2

cat tmp2 | awk '{split($0, a, "\t"); for(i=5; i<=NF;i++) {split(a[i], b, ":");if(b[1] == "./.") {print "-1"} else {if(b[1] == "1/1") {print "2"} else {if(b[1] == "0/0") {print "0"} else {print"1"}}}}}'| awk 'ORS=(NR%39?",":RS)' | tail -n +2 | sed "s/\,/\\t/g" > tmp3

cat tmp2 | tail -n +2 | cut -f1,2,3,4 | awk '{if(length($3) == 1 && length($4) == 1) {print "snv_"$1"_"$2} else {if(length($3) == 1 && length($3) < length($4)) {print "sv:"length($4)-1"I_"$1"_"$2} else {if(length($4) == 1 && length($3) > length($4)) {print "sv:"length($3)-1"D_"$1"_"$2} else {print "sv:"length($3)-1"D"length($4)-1"I_"$1"_"$2}}}}' > tmp4

cat tmp2 | tail -n +2 | cut -f1,2 > tmp5

head -n 1 tmp2 | cut -f 5- | awk '{print "#id\t"$0}' > filtered_freeze2.genotype

paste tmp4 tmp3 >> filtered_freeze2.genotype

echo "" | awk '{print "#id\tchr\tpos"}' > filtered_freeze2.position

paste tmp4 tmp5 >>  filtered_freeze2.position

##extract variant of interest

cat infected_rpkm_variant.txt |  tr -d '\r' |grep -f - filtered_freeze2.genotype > i.QTL.txt

cat naive_rpkm_variant.txt |  tr -d '\r' |grep -f - filtered_freeze2.genotype > b.QTL.txt

