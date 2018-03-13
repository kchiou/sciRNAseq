#!/bin/bash

module load contrib/python/2.7.14

script=primary_pipeline_scripts/sciRNAseq_count.py
# gtf_file=genomes/mouse_human.gtf
gtf_file=genomes/Macaca_mulatta.Mmul_8.0.1.90.gtf
input_folder=output/sam_splitted
sample_ID=output/barcode_samples.txt
core_number=8

output_folder=output/report/gene_count

cat output/sam_splitted/*sample_list.txt > output/sam_splitted/all_samples.txt
cp output/sam_splitted/all_samples.txt output/barcode_samples.txt

# script=$script_folder/sciRNAseq_count.py
echo "Start the gene count...."
python $script $gtf_file $input_folder $sample_ID $core_number

echo "Make the output folder and transfer the files..."
mkdir -p $output_folder
cat $input_folder/*.count > $output_folder/count.MM
rm $input_folder/*.count
cat $input_folder/*.report > $output_folder/report.MM
rm $input_folder/*.report
mv $input_folder/*_annotate.txt $output_folder/
echo "All output files are transferred~"

echo "Analysis is done and gene count matrix is generated~"