#!/bin/bash -l
#SBATCH -A uppmax2024-2-7 
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:15:00
#SBATCH -J Quality_Control_FastQC
#SBATCH --mail-type=ALL
#SBATCH --mail-user matias.becker-burgos.1399@student.uu.se

# Load modules
module load bioinfo-tools
module load FastQC

# Commands 

fastqc -o ~/1MB462_GenomeAnalysis/02_Preprocessing/Quality_Control/ -t 2 ~/1MB462_GenomeAnalysis/01_Raw_Data/3_Thrash_2017/RNA_untrimmed/*.fastaq.gz

fastqc -o ~/1MB462_GenomeAnalysis/02_Preprocessing/Quality_Control/ -t 2 ~/1MB462_GenomeAnalysis/01_Raw_Data/3_Thrash_2017/DNA_trimmed/*.fastq.gz
