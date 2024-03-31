#!/bin/bash -l
#SBATCH -A uppmax2024-2-7 
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 09:00:00
#SBATCH -J Metagenome_Assembly 
#SBATCH --mail-type=ALL
#SBATCH --mail-user matias.becker-burgos.1399@student.uu.se


# Load modules
module load bioinfo-tools
module load megahit
module load quast

# input value

DNA_Trimmed=/home/matiab/1MB462_GenomeAnalysis/01_Raw_Data/DNA_trimmed

Output=/home/matiab/1MB462_GenomeAnalysis/03_Metagenome_Assembly

# Commands 

# Make new directory for Metagenome Assembly and evaluation 

mkdir ~/1MB462_GenomeAnalysis/03_Metagenome_Assembly/Assembly

# Run Metagenomic Assembly 

megahit --kmin-1pass --k-min 65 --k-max 105 --k-step 10 \
-1 ${DNA_Trimmed}/Site_D1_DNA_1.paired.trimmed.fastq.gz \
-2 ${DNA_Trimmed}/Site_D1_DNA_2.paired.trimmed.fastq.gz \
-o ${Output}/Assembly/Site_D1_Assembly/

megahit --kmin-1pass --k-min 65 --k-max 105 --k-step 10 \
-1 ${DNA_Trimmed}/Site_D3_DNA_1.paired.trimmed.fastq.gz \
-2 ${DNA_Trimmed}/Site_D3_DNA_2.paired.trimmed.fastq.gz \
-o ${Output}/Assembly/Site_D3_Assembly/

# Run the assembly evalution 

metaquast.py ${Output}/Assembly/Site_D1_Assembly/final.contigs.fa \
-o ${Output}/Site_D1_Assembly_Evaluation/ -t 2 \
-1 ${DNA_Trimmed}/Site_D1_DNA_1.paired.trimmed.fastq.gz \
-2 ${DNA_Trimmed}/Site_D1_DNA_2.paired.trimmed.fastq.gz 

metaquast.py ${Output}/Assembly/Site_D3_Assembly/final.contigs.fa \
-o ${Output}/Site_D3_Assembly_Evaluation/ -t 2 \
-1 ${DNA_Trimmed}/Site_D3_DNA_1.paired.trimmed.fastq.gz \
-2 ${DNA_Trimmed}/Site_D3_DNA_2.paired.trimmed.fastq.gz
