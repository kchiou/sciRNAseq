#!/bin/bash

module load contrib/star/2.5
module load contrib/parallel/20171122
module load contrib/samtools/1.6
module load contrib/python/2.7.14

script_path=primary_pipeline_scripts
script_folder=primary_pipeline_scripts
mismatch=1
core=8

STAR_output_folder=output/STAR_alignment
filtered_sam_folder=output/filtered_sam
rmdup_sam_folder=output/rmdup_sam

sample=`sed -n ${SLURM_ARRAY_TASK_ID}p sample_list.txt`

echo Filtering $sample

mkdir -p $filtered_sam_folder

samtools view -bh -q 30 -F 4 $STAR_output_folder/$sample*.sam | samtools sort -@ 8 - | samtools view -h - > $filtered_sam_folder/$sample.sam;

echo remove duplicate $sample;

mkdir -p $rmdup_sam_folder

python $script_path/rm_dup_barcode_UMI.py $filtered_sam_folder/$sample.sam $rmdup_sam_folder/$sample.sam $mismatch;

sam_folder=output/rmdup_sam
# bash $script_folder/samfile_split_multi_threads.sh $sam_folder $sample_ID $out_folder $barcodes $cutoff
#sample_list=$sample_ID
output_folder=output/sam_splitted
barcode_file=rt_barcodes.txt
cutoff=1

echo
echo "Start splitting the sam file..."

mkdir -p $output_folder

echo Now splitting $sample;

python $script_path/sam_split.py $sam_folder/$sample.sam $barcode_file $output_folder $cutoff;

fastq_folder=input
trimmed_folder=output/trimmed_fastq
UMI_attach=output/UMI_attach
alignment=$STAR_output_folder
filtered_sam=$filtered_sam_folder
rm_dup_sam=$rmdup_sam_folder

report_folder=output/report/read_num

mkdir -p $report_folder

echo calculating $sample;
echo $sample,$(expr $(zcat $fastq_folder/$sample*R2*.fastq.gz|wc -l) / 4),$(expr $(zcat $UMI_attach/$sample*R2*.gz|wc -l) / 4),$(expr $(zcat $trimmed_folder/$sample*R2*.gz|wc -l) / 4),$(samtools view $filtered_sam/$sample.sam|wc -l),$(samtools view $rm_dup_sam/$sample.sam|wc -l)>>$report_folder/read_number.csv;

exit;