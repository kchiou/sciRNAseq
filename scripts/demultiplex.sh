#!/bin/bash

fastq_folder=input
all_output_folder=output
cutoff=1
barcodes=rt_barcodes.txt
index=genomes
script_folder=primary_pipeline_scripts/
core=1

# define the mismatch rate (edit distance) of UMIs for removing duplicates:
mismatch=1

#define the bin of python
module load contrib/python/2.7.14

# python_path=/usr/bin/python
python_path=/sw/contrib/python/2.7.14/bin/

sample=`sed -n ${SLURM_ARRAY_TASK_ID}p sample_list.txt`

#define the location of script:
script_path=$script_folder

module load contrib/samtools/1.6
module load contrib/bedtools/2.26.0

############ RT barcode and UMI attach
# this script take in a input folder, a sample ID, a output folder, a oligo-dT barcode file and
# call the python script to extract the UMI and RT barcode from read1 and attach them to the read names of read2

input_folder=$fastq_folder
output_folder=$all_output_folder/UMI_attach
script=$script_folder/UMI_barcode_attach_gzipped.py

# echo "changing the name of the fastq files..."
# 
# for sample in $(cat $sample_ID); do echo changing name $sample; mv $input_folder/$sample*R1*gz $input_folder/$sample.R1.fastq.gz; mv $input_folder/$sample*R2*gz $input_folder/$sample.R2.fastq.gz; done

echo "Attaching barcode and UMI...."
mkdir -p $output_folder
$python_path/python $script $input_folder $sample $output_folder $barcodes $core
echo "Barcode transformed and UMI attached."

################# Trim the read2
echo
echo "Start trimming the read2 file..."
echo $(date)

module load contrib/cutadapt/1.15
module load contrib/trim_galore/0.4.5

mkdir -p $all_output_folder/trimmed_fastq
trimmed_fastq=$all_output_folder/trimmed_fastq
UMI_attached_R2=$all_output_folder/UMI_attach
echo trimming $sample;

trim_galore ${UMI_attached_R2}/${sample}.R2.fastq.gz -a AAAAAAAA --three_prime_clip_R1 1 -o $trimmed_fastq

echo "All trimmed file generated."
