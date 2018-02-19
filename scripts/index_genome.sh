#!/bin/bash
#
#SBATCH --verbose
#SBATCH --job-name=index_genome
#SBATCH --output=/gscratch/hpc/kchiou/slurm_%j.out
#SBATCH --error=/gscratch/hpc/kchiou/slurm_%j.err
#SBATCH --mail-user=kchiou@uw.edu
#SBATCH --mail-type=ALL
#SBATCH --time=24:00:00
#SBATCH --nodes=8
#SBATCH --mem=32GB
#SBATCH --account=hpc
#SBATCH --partition=hpc

# sbatch index_genome.sh

module load contrib/star/2.5

cd /gscratch/hpc/kchiou/sciRNAseq

STAR --runThreadN 8 --runMode genomeGenerate --genomeDir genomes/ --genomeChrBinNbits 8 --genomeFastaFiles genomes/Macaca_mulatta.Mmul_8.0.1.dna.toplevel.fa

exit;