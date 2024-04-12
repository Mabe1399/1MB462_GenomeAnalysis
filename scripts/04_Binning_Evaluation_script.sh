#!/bin/bash -l
#SBATCH -A uppmax2024-2-7 
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 10:00:00
#SBATCH -J Binning and evaluation 
#SBATCH --mail-type=ALL
#SBATCH --mail-user matias.becker-burgos.1399@student.uu.se


# Load modules
module load bioinfo-tools
module load metabat
module load CheckM

# Path assesed 

DNA_assmebly=/home/matiab/1MB462_GenomeAnalysis/03_Metagenome_Assembly/Assembly

Mapped_DNA=/home/matiab/1MB462_GenomeAnalysis/04_Binning/DNA_Mapping

Output=/home/matiab/1MB462_GenomeAnalysis/04_Binning

# Create New directory

mkdir ~/1MB462_GenomeAnalysis/04_Binning/Bins

mkdir ~/1MB462_GenomeAnalysis/04_Binning/Bins/Combined_Bins

mkdir ~/1MB462_GenomeAnalysis/04_Binning/Bins/Separate_Bins  

mkdir ~/1MB462_GenomeAnalysis/04_Binning/Bins_Evaluation

# Run the binning software
# Create the depth files 

jgi_summarize_bam_contig_dephts --outputDepth depth_Site_D1.txt \
${Mapped_DNA}/Site_D1_DNA_Sorted_mapping.bam

jgi_summarize_bam_contig_dephts --outputDepth depth_Site_D3.txt \
${Mapped_DNA}/Site_D3_DNA_Sorted_mapping.bam

jgi_summarize_bam_contig_dephts --outputDepth depth_Combined.txt \
${Mapped_DNA}/Combined_DNA_Sorted_mapping_D1.bam \
${Mapped_DNA}/Combined_DNA_sorted_mapping_D3.bam

# Run MetaBat 

metabat2 -i ${DNA_assembly}/Site_D1_Assembly/Site_D1_final.contigs.fa \
-a ${Mapped_DNA}/depth_Site_D1.txt -o ${Output}/Bins/Separate_Bins/Site_D1

metabat2 -i ${DNA_assembly}/Site_D3_Assembly/Site_D3_final.contigs.fa \
-a ${Mapped_DNA}/depth_Site_D3.txt -o ${Output}/Bins/Separate_Bins/Site_D3

metabat2 -i ${DNA_assembly}/Combined_Assembly/final.contigs.fa \
-a ${Mapped_DNA}/depth_Combined.txt -o ${Output}/Bins/Combined_Bins/

# Create temporary directories

tmpdir = $SNIC_TMP/Binning_Evaluation
mkdir $tmpdir
mkdir $tmpdir/Separate_Bins
mkdir $tmpdir/Combined_Bins
mkdir $tmpdir/CheckM_Database
mkdir $tmpdir/Results

# Copy data to temporary directory

cp ${Output}/Bins/Combined_Bins/* $tmpdir/Combined_Bins/
cp ${Output}/Bins/Separate_Bins/* $tmpdir/Separate_Bins/
cp -av $CHECKM_DATA/checkm_data_2015_01_16.tar.gz $tmpdir/CheckM_Database/

# Set the Database file 

mkdir $tmpdir/CheckM_Database/2015_01_16
cd $tmpdir/CheckM_Database/2015_01_16
tar xzf ../checkm_data_2015_01_16.tar.gz

checkm data setRoot $PWD

# Check Quality

checkm lineage_wf -t 4 -x fa --reduced_tree $tmpdir/Separate_Bins/ \
$tmpdir/Results

checkm lineage_wf -t 4 -x fa --reduced_tree $tmpdir/Combined_Bins/ \
$tmpdir/Results

# Retrieve the data 
cp -r $tmpdir/Results/* ${Output}/Bins_Evaluation/
