#!/bin/bash -l
#SBATCH -A uppmax2024-2-7 
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 30:00:00
#SBATCH -J eggNOG_Annotation
#SBATCH --mail-type=ALL
#SBATCH --mail-user matias.becker-burgos.1399@student.uu.se


# Load modules
module load bioinfo-tools
module load eggNOG-mapper

# Path of files to iterate

Bins=/home/matiab/1MB462_GenomeAnalysis/04_Binning/Bins

Prokka=/home/matiab/1MB462_GenomeAnalysis/05_Annotation

Output=/home/matiab/1MB462_GenomeAnalysis/08_Extra_Analysis

# Create New Directory

mkdir $Output/Extra_Annotation
cd $Output/Extra_Annotation

# Make temporary directory

tmpdir=$SNIC_TMP/Annotation
mkdir $tmpdir
mkdir $tmpdir/Data
mkdir $tmpdir/Results

# Make temporary copies of relevent files

cp $Bins/Bins_5.fa $Bins/Bins_16.fa $Bins/Bins_29.fa $Bins/Bins_12.fa $tmpdir/Data/

# Run eggNOG for Annotation

for x in 5 16 29 12 ; do

emapper.py --cpu 2 -m diamond --data_dir $EGGNOG_DATA_ROOT/ --report_orthologs \
-i $tmpdir/Data/Bins_${x}.fa --itype genome --genepred prodigal --decorate_gff <(sed '/##FASTA/,$d' $Prokka/Bins_${x}/Bins_${x}.gff) \
-o Bins_${x} --output_dir $tmpdir/Results \
--excel

done 

cp -r $tmpdir/Results/* $Output/Extra_Annotation