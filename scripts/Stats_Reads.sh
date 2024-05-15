#!/bin/bash -l
#SBATCH -A uppmax2024-2-7 
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 05:00:00
#SBATCH -J RNA_Mapping 
#SBATCH --mail-type=ALL
#SBATCH --mail-user matias.becker-burgos.1399@student.uu.se


# Load modules
module load bioinfo-tools
module load samtools

# Path of files to iterate

Mapped_RNA=/home/matiab/1MB462_GenomeAnalysis/06_Analysis_of_Expression/RNA_Mapping

Output=/home/matiab/1MB462_GenomeAnalysis/06_Analysis_of_Expression

# Run the Read counting Htseq

for x in Bins_5 Bins_12 Bins_16 Bins_29 ; do

samtools stats $Mapped_RNA/${x}.fa_D1.bam > $Mapped_RNA/${x}.D1.stats.txt
samtools stats $Mapped_RNA/${x}.fa_D3.bam > $Mapped_RNA/${x}.D3.stats.txt

done