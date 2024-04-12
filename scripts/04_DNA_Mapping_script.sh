#!/bin/bash -l
#SBATCH -A uppmax2024-2-7 
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 15:00:00
#SBATCH -J RNA_Mapping 
#SBATCH --mail-type=ALL
#SBATCH --mail-user matias.becker-burgos.1399@student.uu.se


# Load modules
module load bioinfo-tools
module load bwa
module load samtools

# Path of files to iterate

Bins=/home/matiab/1MB462_GenomeAnalysis/04_Binning/Bins

Trimmed_RNA=/home/matiab/1MB462_GenomeAnalysis/02_Preprocessing/Trimming

Output=/home/matiab/1MB462_GenomeAnalysis/06_Analysis_of_Expression

# Make temporary folder
tmpdir=$SNIC_TMP/RNA_Mapping
mkdir $tmpdir
mkdir $tmpdir/Data

#Makw temporary copies of relevent files
 
cp $Bins/Bin* $tmpdir/Data/

# Create New directory

mkdir $Output/RNA_Mapping

mkdir $Output/RNA_Mapping/Site_D1

mkdir $Output/RNA_Mapping/Site_D3

# Run alignement

for x in $tmpdir/Data/
do
bwa index $tmpdir/Data/x

bwa mem -t 2 $tmpdir/Data/x \
${Trimmed_RNA}/Site_D1_RNA_1.paired.trimmed.fastq.gz \
${Trimmed_RNA}/Site_D1_RNA_2.paired.trimmed.fastq.gz > $tmpdir/Site_D1_RNA_Raw_Mapping_{x}.sam

bwa mem -t 2 $tmpdir/Data/x \
${Trimmed_RNA}/Site_D1_RNA_1.paired.trimmed.fastq.gz \
${Trimmed_RNA}/Site_D1_RNA_2.paired.trimmed.fastq.gz > $tmpdir/Site_D3_RNA_Raw_Mapping_{x}.sam

samtools sort $tmpdir/Site_D1_RNA_Raw_Mapping_{x}.sam \
-o $tmpdir/Site_D1_RNA_Sorted_mapping{x}.bam 

rm $tmpdir/Site_D1_RNA_Raw_Mapping_{x}.sam

samtools sort $tmpdir/Site_D3_RNA_Raw_Mapping_{x}.sam \
-o $tmpdir/Site_D3_RNA_Sorted_mapping_{x}.bam

rm $tmpdir/Site_D3_RNA_Raw_Mapping_{x}.sam
done

# Copy desired file to my directory
cp -r $tmpdir/Site_D1*.bam $Output/RNA_Mapping/Site_D1

cp -r $tmpdir/Site_D3*.bam $Output/RNA_Mapping/Site_D3
