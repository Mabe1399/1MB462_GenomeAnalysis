#!/bin/bash -l
#SBATCH -A uppmax2024-2-7 
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 05:00:00
#SBATCH -J Functional_Annotation 
#SBATCH --mail-type=ALL
#SBATCH --mail-user matias.becker-burgos.1399@student.uu.se


# Load modules
module load bioinfo-tools
module load prokka

# Path of files to iterate

Bins=/home/matiab/1MB462_GenomeAnalysis/04_Binning/Bins

Output=/home/matiab/1MB462_GenomeAnalysis/05_Annotation

# Run Prokka for Annotation

prokka --outdir $Output/Bins_5 --prefix Bins_5 $Bins/Bins_5.fa

prokka --outdir $Output/Bins_12 --prefix Bins_12 $Bins/Bins_12.fa

prokka --outdir $Output/Bins_16 --prefix Bins_16 $Bins/Bins_16.fa

prokka --outdir $Output/Bins_29 --prefix Bins_29 $Bins/Bins_29.fa
