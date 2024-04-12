#!/bin/bash -l
#SBATCH -A uppmax2024-2-7 
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 10:00:00
#SBATCH -J Binning_and_evaluation 
#SBATCH --mail-type=ALL
#SBATCH --mail-user matias.becker-burgos.1399@student.uu.se


# Load modules
module load bioinfo-tools
module load MetaBat
module load CheckM

# Path assesed 

DNA_assembly=/home/matiab/1MB462_GenomeAnalysis/03_Metagenome_Assembly/Assembly

Mapped_DNA=/home/matiab/1MB462_GenomeAnalysis/04_Binning/DNA_Mapping

Output=/home/matiab/1MB462_GenomeAnalysis/04_Binning

# Create New directory

mkdir ~/1MB462_GenomeAnalysis/04_Binning/Bins  

mkdir ~/1MB462_GenomeAnalysis/04_Binning/Bins_Evaluation

cd ${Output}/Bins/

# Run the binning software
# Create the depth files 

#jgi_summarize_bam_contig_depths --outputDepth depth_Combined.txt \
#${Mapped_DNA}/Combined_DNA_Sorted_mapping_D1.bam \
#${Mapped_DNA}/Combined_DNA_Sorted_mapping_D3.bam

# Run MetaBat  

#metabat2 -t 2 -i ${DNA_assembly}/Combined_Assembly/final.contigs.fa \
#-a ${Output}/Bins/depth_Combined.txt -o ${Output}/Bins

# Create temporary directories

tmpdir=$SNIC_TMP/Binning_Evaluation
mkdir $tmpdir
mkdir $tmpdir/Bins
mkdir $tmpdir/CheckM_Database
mkdir $tmpdir/Results

# Copy data to temporary directory

cp ${Output}/Bins/*.fa $tmpdir/Bins/
cp -av $CHECKM_DATA/checkm_data_2015_01_16.tar.gz $tmpdir/CheckM_Database/

# Set the Database file 

mkdir $tmpdir/CheckM_Database/2015_01_16
cd $tmpdir/CheckM_Database/2015_01_16
tar xzf ../checkm_data_2015_01_16.tar.gz

checkm data setRoot $PWD

# Check Quality

checkm lineage_wf -t 4 -x fa --reduced_tree $tmpdir/Bins/ \
$tmpdir/Results

# Retrieve the data 
cp -r $tmpdir/Results/* ${Output}/Bins_Evaluation/
