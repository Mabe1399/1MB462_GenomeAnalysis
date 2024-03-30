#!/bin/bash -l
#SBATCH -A uppmax2024-2-7 
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:30:00
#SBATCH -J Quality_Control_FastQC_BeforeTrimming
#SBATCH --mail-type=ALL
#SBATCH --mail-user matias.becker-burgos.1399@student.uu.se

# Load modules
module load bioinfo-tools
module load FastQC

# Commands 

# Create new directories for the results
mkdir ~/1MB462_GenomeAnalysis/02_Preprocessing/Quality_Control/DNA_Trimmed
mkdir ~/1MB462_GenomeAnalysis/02_Preprocessing/Quality_Control/RNA_Untrimmed

# Run Quality Control Analysis

# DNA trimmed quality control
fastqc -o ~/1MB462_GenomeAnalysis/02_Preprocessing/Quality_Control/DNA_Trimmed \
-t 2 ~/1MB462_GenomeAnalysis/01_Raw_Data/DNA_trimmed/*.trimmed.fastq.gz

# RNA untrimmed quality control
fastqc -o ~/1MB462_GenomeAnalysis/02_Preprocessing/Quality_Control/RNA_Untrimmed \
-t 2 ~/1MB462_GenomeAnalysis/01_Raw_Data/RNA_untrimmed/*.fastq.gz
