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
module load bwa
module load samtools

# Path of files to iterate

Bins=/home/matiab/1MB462_GenomeAnalysis/04_Binning/Bins

Trimmed_RNA=/home/matiab/1MB462_GenomeAnalysis/02_Preprocessing/Trimming

Output=/home/matiab/1MB462_GenomeAnalysis/06_Analysis_of_Expression

# Make temporary directory
tmpdir=$SNIC_TMP/RNA_Mapping
mkdir $tmpdir
mkdir $tmpdir/Data

# Make temporary copies of relevent files
cp ${Bins}/*.fa $tmpdir/Data/

# Create New directory

mkdir ~/1MB462_GenomeAnalysis/06_Analysis_of_Expression/RNA_Mapping

# Run the RNA alignement
for x in $tmpdir/Data/* ; do

bwa index $x 

bwa mem -t 2 $x \
${Trimmed_RNA}/Site_D1_RNA_1.paired.trimmed.fastq.gz \
${Trimmed_RNA}/Site_D1_RNA_2.paired.trimmed.fastq.gz \
> $tmpdir/Site_D1_RNA_{x}_Raw_mapping.sam

bwa mem -t 2 $x \
${Trimmed_RNA}/Site_D3_RNA_1.paired.trimmed.fastq.gz \
${Trimmed_RNA}/Site_D3_RNA_2.paired.trimmed.fastq.gz \
> $tmpdir/Site_D3_RNA_{x}_Raw_mapping.sam

# Run Samtools to create BAM file

samtools sort $tmpdir/Site_D1_RNA_{x}_Raw_mapping.sam > \
-o $tmpdir/Site_D1_RNA_{x}_Sorted_mapping.bam 

samtools sort $tmpdir/Site_D3_RNA_{x}_Raw_mapping.sam > \
-o $tmpdir/Site_D3_RNA_{x}_Sorted_mapping.bam

rm $tmpdir/Site_*_RNA_{x}_Raw_mapping.sam
done

# Retrieve the Data 

cp -r $tmpdir/*.bam $Output/RNA_Mapping
