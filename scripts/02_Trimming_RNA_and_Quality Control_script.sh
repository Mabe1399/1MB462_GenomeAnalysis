#!/bin/bash -l
#SBATCH -A uppmax2024-2-7 
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:04:00
#SBATCH -J RNA_Trimming 
#SBATCH --mail-type=ALL
#SBATCH --mail-user matias.becker-burrgos.1399@student.uu.se

# Load modules
module load bioinfo-tools
module load trimmomatic
module load FastQC

# Commands 

# Run the trimming software for site_D1_RNA

java -jar $TRIMMOMATIC_ROOT/trimmomatic.jar PE \
-trimlog ~/1MB461_GenomeAnalysis/02_Preprocessing/Trimming/Site_D1_RNA.trimlog \
-basein ~/1MB462_GenomeAnalysis/01_Raw_Data/RNA_Untrimmed/Site_D1_RNA_1.fastq.gz \
~/1MB462_GenomeAnalysis/02_Preprocessing/Trimming/Site_D1_RNA_1.unpaired.trimmed.fastq.gz \
~/1MB462_GenomeAnalysis/02_Preprocessing/Trimming/Site_D1_RNA_1.paired.trimmed.fastq.gz \
~/1MB462_GenomeAnalysis/02_Preprocessing/Trimming/Site_D1_RNA_2.unpaired.trimmed.fastq.gz \
~/1MB462_GenomeAnalysis/02_Preprocessing/Trimming/Site_D1_RNA_2.paired.trimmed.fastq.gz

# Run the trimming software for	site_D3_RNA

java -jar $TRIMMOMATIC_ROOT/trimmomatic.jar PE \
-trimlog ~/1MB462_GenomeAnalysis/02_Preprocessing/Trimming/Site_D3_RNA \
-basein ~/1MB462_GenomeAnalysis/01_Raw_Data/RNA_Untrimmed/Site_D3_RNA_1.fastq.gz \
~/1MB462_GenomeAnalysis/02_Preprocessing/Trimming/Site_D3_RNA_1.unpaired.trimmed.fastq.gz \
~/1MB462_GenomeAnalysis/02_Preprocessing/Trimming/Site_D3_RNA_1.paired.trimmed.fastq.gz \
~/1MB462_GenomeAnalysis/02_Preprocessing/Trimming/Site_D3_RNA_2.unpaired.trimmed.fastq.gz \
~/1MB462_GenomeAnalysis/02_Preprocessing/Trimming/Site_D3_RNA_2.paired.trimmed.fastq.gz

# Create new directory for Quality control

mkdir ~/1MB462_GenomeAnalysis/02_Preprocessing/Quality_Control/RNA_Trimmed

# Quality Control of Paired RNA sequence

fastqc -o ~/1MB462_GenomeAnalysis/02_Preprocessing/Quality_Control/RNA_Trimmed \
-t 2 ~/1MB462_GenomeAnalysis/02_Preprocessing/Trimming/*.paired.trimmed.fastq.gz
