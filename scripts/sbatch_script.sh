#!/bin/bash -l
#SBATCH -A uppmax2024-2-7 
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 03:00:00
#SBATCH -J DNA_Mapping 
#SBATCH --mail-type=ALL
#SBATCH --mail-user matias.becker-burgos.1399@student.uu.se


# Load modules
module load bioinfo-tools
module load bwa

# Variables

DNA_assmebly=/home/matiab/1MB462_GenomeAnalysis/03_Metagenome_Assembly/Assembly

Raw_DNA=/home/matiab/1MB462_GenomeAnalysis/01_Raw_Data/DNA_trimmed

Output=/home/matiab/1MB462_GenomeAnalysis/04_Binning

# Commands 

# Create New directory

mkdir ~/1MB462_GenomeAnalysis/04_Binning/DNA_Mapping

# Run the DNA alignement

bwa mem -t 2 ${DNA_assembly}/Site_D1_Assembly/final.contigs.fa \
${Raw_DNA}/Site_D1_DNA_1.paired.trimmed.fastq.gz \
${Raw_DNA}/Site_D1_DNA_2.paired.trimmed.fastq.gz \
> ${Output}/DNA_Mapping/Site_D1_DNA_Raw_mapping.sam

bwa mem -t 2 ${DNA_assembly}/Site_D1_Assembly/final.contigs.fa \
${Raw_DNA}/Site_D1_DNA_1.paired.trimmed.fastq.gz \
${Raw_DNA}/Site_D1_DNA_2.paired.trimmed.fastq.gz \
> ${Output}/DNA_Mapping/Site_D1_DNA_Raw_mapping.sam

# Run Samtools to create BAM file

samtools sort $/Site_D1_DNA_Raw_mapping.sam > \
-o ${Output}/DNA_Mapping/Site_D1_DNA_Raw_mapping.bam 
rm ${Output}/DNA_Mapping/Site_D1_DNA_Raw_mapping.sam

samtools sort $/Site_D1_DNA_Raw_mapping.sam > \
-o ${Output}/DNA_Mapping/Site_D1_DNA_Raw_mapping.bam
rm ${Output}/DNA_Mapping/Site_D1_DNA_Raw_mapping.sam

