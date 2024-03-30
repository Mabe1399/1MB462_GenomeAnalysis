#!/bin/bash -l
#SBATCH -A uppmax2024-2-7 
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 07:00:00
#SBATCH -J Metagenome Assembly 
#SBATCH --mail-type=ALL
#SBATCH --mail-user matias.becker-burgos.1399@student.uu.se


# Load modules
module load bioinfo-tools
module load Megahit

# Commands 

# Create new directory 

mkdir ~/1MB462_GenomeAnalysis/03_Metagenome_Assembly/Assembly

