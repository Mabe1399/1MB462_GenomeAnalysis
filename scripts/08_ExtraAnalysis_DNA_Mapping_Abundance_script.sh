#!/bin/bash -l
#SBATCH -A uppmax2024-2-7 
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 08:00:00
#SBATCH -J DNA_Mapping_Abundance 
#SBATCH --mail-type=ALL
#SBATCH --mail-user matias.becker-burgos.1399@student.uu.se


# Load modules
module load bioinfo-tools
module load bwa
module load samtools
module load htseq

# Path of files to iterate

Bins=/home/matiab/1MB462_GenomeAnalysis/04_Binning/Bins

Bins_Annotation=/home/matiab/1MB462_GenomeAnalysis/05_Annotation

DNA=/home/matiab/1MB462_GenomeAnalysis/01_Raw_Data/DNA_trimmed

Output=/home/matiab/1MB462_GenomeAnalysis/08_Extra_Analysis

# Make temporary directory
tmpdir=$SNIC_TMP/DNA_Mapping
mkdir $tmpdir
mkdir $tmpdir/Data

# Make temporary copies of relevent files
cp $Bins/Bins_5.fa $Bins/Bins_16.fa $Bins/Bins_29.fa $Bins/Bins_12.fa $tmpdir/Data/

# Create New directory

mkdir ~/1MB462_GenomeAnalysis/08_Extra_Analysis/Abundance_Analysis
mkdir ~/1MB462_GenomeAnalysis/08_Extra_Analysis/Abundance_Analysis/DNA_Mapping

# Run the RNA alignement
for x in 5 16 29 12 ; do

bwa index $tmpdir/Data/Bins_${x}.fa 

bwa mem -t 2 $tmpdir/Data/Bins_${x}.fa -P \
${DNA}/Site_D1_DNA_1.paired.trimmed.fastq.gz \
${DNA}/Site_D1_DNA_2.paired.trimmed.fastq.gz > $tmpdir/Bins_${x}_D1.sam

bwa mem -t 2 $tmpdir/Data/Bins_${x}.fa -P \
${DNA}/Site_D3_DNA_1.paired.trimmed.fastq.gz \
${DNA}/Site_D3_DNA_2.paired.trimmed.fastq.gz > $tmpdir/Bins_${x}_D3.sam

# Run Samtools to create BAM file

samtools sort $tmpdir/Bins_${x}_D1.sam \
-o $tmpdir/Bins_${x}_D1.bam 

samtools sort $tmpdir/Bins_${x}_D3.sam \
-o $tmpdir/Bins_${x}_D3.bam

samtools coverage $tmpdir/Bins_${x}_D1.bam > $tmpdir/Bins_${x}_D1_stats.txt
samtools coverage $tmpdir/Bins_${x}_D3.bam > $tmpdir/Bins_${x}_D3_stats.txt

rm $tmpdir/*.sam

done 

# Retrieve the Data
cp -r $tmpdir/*.txt $Output/Abundance_Analysis/Read_Count