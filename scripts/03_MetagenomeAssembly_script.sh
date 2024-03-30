#!/bin/bash -l
#SBATCH -A uppmax2024-2-7 
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 08:00:00
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

# Create new directory for Evaluation 

mkdir ~/1MB462_GenomeAnalysis/03_Metagenome_Assembly/Assembly_Evaluation

# Run Metagenomic Assembly 

megahit --kmin-1pass --k-min 65 --k-max 105 --k-step 10 \
-1 ${DNA_Trimmed}/Site_D1_DNA_1.paired.trimmed.fastq.gz,\
${DNA_Trimmed}/Site_D3_DNA_1.paired.trimmed.fastq.gz \
-2 ${DNA_Trimmed}/Site_D1_DNA_2.paired.trimmed.fastq.gz,\
${DNA_Trimmed}/Site_D3_DNA_2.paired.trimmed.fastq.gz \
-o ${Output}/Assembly/

# Run the assembly evalution 

metaquast.py -t 2 ${Output}/Assembly/ -o ${Output}/Assembly_Evaluation/ \
-1 ${DNA_Trimmed}/*_1.paired.trimmed.fastq.gz \
-2 ${DNA_Trimmed}/*_2.paired.trimmed.fastq.gz
 
