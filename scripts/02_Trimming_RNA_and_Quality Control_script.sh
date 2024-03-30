#!/bin/bash -l
#SBATCH -A uppmax2024-2-7 
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 03:00:00
#SBATCH -J RNA_Trimming 
#SBATCH --mail-type=ALL
#SBATCH --mail-user matias.becker-burrgos.1399@student.uu.se

# Load modules
module load bioinfo-tools
module load trimmomatic
module load FastQC
module load MultiQC

# Commands 

# Run the trimming software for site_D1_RNA

java -jar $TRIMMOMATIC_ROOT/trimmomatic.jar PE -threads 2 \
-trimlog ~/1MB462_GenomeAnalysis/02_Preprocessing/Trimming/Site_D1_RNA.trimlog \
-basein ~/1MB462_GenomeAnalysis/01_Raw_Data/RNA_untrimmed/Site_D1_RNA_1.fastq.gz \
~/1MB462_GenomeAnalysis/02_Preprocessing/Trimming/Site_D1_RNA_1.unpaired.trimmed.fastq.gz \
~/1MB462_GenomeAnalysis/02_Preprocessing/Trimming/Site_D1_RNA_1.paired.trimmed.fastq.gz \
~/1MB462_GenomeAnalysis/02_Preprocessing/Trimming/Site_D1_RNA_2.unpaired.trimmed.fastq.gz \
~/1MB462_GenomeAnalysis/02_Preprocessing/Trimming/Site_D1_RNA_2.paired.trimmed.fastq.gz \
ILLUMINACLIP:$TRIMMOMATIC_HOME/adapters/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

# Run the trimming software for	site_D3_RNA

java -jar $TRIMMOMATIC_ROOT/trimmomatic.jar PE -threads 2 \
-trimlog ~/1MB462_GenomeAnalysis/02_Preprocessing/Trimming/Site_D3_RNA.trimlog \
-basein ~/1MB462_GenomeAnalysis/01_Raw_Data/RNA_untrimmed/Site_D3_RNA_1.fastq.gz \
~/1MB462_GenomeAnalysis/02_Preprocessing/Trimming/Site_D3_RNA_1.unpaired.trimmed.fastq.gz \
~/1MB462_GenomeAnalysis/02_Preprocessing/Trimming/Site_D3_RNA_1.paired.trimmed.fastq.gz \
~/1MB462_GenomeAnalysis/02_Preprocessing/Trimming/Site_D3_RNA_2.unpaired.trimmed.fastq.gz \
~/1MB462_GenomeAnalysis/02_Preprocessing/Trimming/Site_D3_RNA_2.paired.trimmed.fastq.gz \
ILLUMINACLIP:$TRIMMOMATIC_HOME/adapters/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

# Create new directory for Quality control

mkdir ~/1MB462_GenomeAnalysis/02_Preprocessing/Quality_Control/RNA_Trimmed

# Quality Control of Paired RNA sequence

fastqc -o ~/1MB462_GenomeAnalysis/02_Preprocessing/Quality_Control/RNA_Trimmed \
-t 2 ~/1MB462_GenomeAnalysis/02_Preprocessing/Trimming/*.paired.trimmed.fastq.gz

cd ~/1MB462_GenomeAnalysis/02_Preprocessing/Quality_Control/RNA_Trimmed

multiqc ~/1MB462_GenomeAnalysis/02_Preprocessing/Quality_Control/RNA_Trimmed -p
