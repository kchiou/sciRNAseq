#!/bin/bash

module load contrib/samtools/1.6

sampleID=`sed -n ${SLURM_ARRAY_TASK_ID}p sample_list.txt | sed 's/\([A-Z]*\)\.[A-Z]*/\1/g'`

sample_files=$(ls -1 output/sam_splitted/${sampleID}*.sam)

for sample_file in $sample_files; do
pcr=$(echo $sample_file | sed 's/output\/sam_splitted\/\([A-Z]*\)\.\([A-Z]*\)\.sam/\1/g')
rt=$(echo $sample_file | sed 's/output\/sam_splitted\/\([A-Z]*\)\.\([A-Z]*\)\.sam/\2/g')
cell=$(echo $sample_file | sed 's/output\/sam_splitted\/\([A-Z]*\)\.\([A-Z]*\)\.sam/\1.\2/g')
echo $cell,$pcr,$rt,$(samtools view $sample_file | grep Hs | wc -l),$(samtools view $sample_file | grep Mm | wc -l),$(samtools view $sample_file | grep Hs | grep Mm | wc -l) >> output/report/mouse_human.csv
done;