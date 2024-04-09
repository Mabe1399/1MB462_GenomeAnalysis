#!/bin/bash -l
#SBATCH -A uppmax2024-2-7 
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 15:00:00
#SBATCH -J DNA_Mapping 
#SBATCH --mail-type=ALL
#SBATCH --mail-user matias.becker-burgos.1399@student.uu.se


# Load modules
module load bioinfo-tools
module load bwa
module load samtools

# Path of files to iterate

DNA_Assembly=/home/matiab/1MB462_GenomeAnalysis/03_Metagenome_Assembly/Assembly

Raw_DNA=/home/matiab/1MB462_GenomeAnalysis/01_Raw_Data/DNA_trimmed

Output=/home/matiab/1MB462_GenomeAnalysis/04_Binning

# Make temporary folder
tmpdir=$SNIC_TMP/DNA_Mapping
mkdir $tmpdir
mkdir $tmpdir/Data

#Makw temporary copies of relevent files 
cp $DNA_Assembly/Site_D1_Assembly/Site_D1_final.contigs.fa $tmpdir/Data/
cp $DNA_Assembly/Site_D3_Assembly/Site_D3_final.contigs.fa $tmpdir/Data/

# Create New directory

mkdir ~/1MB462_GenomeAnalysis/04_Binning/DNA_Mapping
mkdir ~/1MB462_GenomeAnalysis/04_Binning/DNA_Mapping/Site_D3_Database

# Create Databases

bwa index $tmpdir/Data/Site_D1_final.contigs.fa

bwa index $tmpdir/Data/Site_D3_final.contigs.fa

# Run the DNA alignement

bwa mem -t 2 $tmpdir/Data/Site_D1_final.contigs.fa \
${Raw_DNA}/Site_D1_DNA_1.paired.trimmed.fastq.gz \
${Raw_DNA}/Site_D1_DNA_2.paired.trimmed.fastq.gz > $tmpdir/Site_D1_DNA_Raw_mapping.sam

bwa mem -t 2 $tmpdir/Data/Site_D3_final.contigs.fa \
${Raw_DNA}/Site_D3_DNA_1.paired.trimmed.fastq.gz \
${Raw_DNA}/Site_D3_DNA_2.paired.trimmed.fastq.gz > $tmpdir/Site_D3_DNA_Raw_mapping.sam

# Run Samtools to create BAM file

samtools sort $tmpdir/Site_D1_DNA_Raw_mapping.sam \
-o $tmpdir/Site_D1_DNA_Sorted_mapping.bam
 
rm $tmpdir/Site_D1_DNA_Raw_mapping.sam

samtools sort $tmpdir/Site_D3_DNA_Raw_mapping.sam \
-o $tmpdir/Site_D3_DNA_sorted_mapping.bam
rm $tmpdir/Site_D3_DNA_Raw_mapping.sam

# Copy desired file to my directory
cp -r $tmpdir/*.bam $Output/DNA_Mapping
