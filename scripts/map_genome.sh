#!/bin/bash

module load contrib/star/2.5

mkdir -p output/STAR_alignment

sample=`sed -n ${SLURM_ARRAY_TASK_ID}p sample_list.txt`
core=8
index=genomes/
input_folder=output/trimmed_fastq
STAR_output_folder=output/STAR_alignment

echo Aligning $sample
STAR --runThreadN $core --outSAMstrandField intronMotif --genomeDir $index --readFilesCommand zcat --readFilesIn $input_folder/$sample*gz --outFileNamePrefix $STAR_output_folder/$sample

exit