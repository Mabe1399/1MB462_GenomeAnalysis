#!/bin/bash -l
#SBATCH -A uppmax2024-2-7 
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 08:00:00
#SBATCH -J Phylogenetic_placement
#SBATCH --mail-type=ALL
#SBATCH --mail-user matias.becker-burgos.1399@student.uu.se


# Load modules
module load bioinfo-tools
module load conda

# set up of the conda environement

export CONDA_ENVS_PATH=/proj/uppmax2024-2-7/Genome_Analysis/conda_envs
source conda_init.sh
conda activate phylophlan

# Path of files to iterate

phylophlan=/proj/uppmax2024-2-7/Genome_Analysis/conda_envs
Output=/home/matiab/1MB462_GenomeAnalysis/07_Phylogeny
Bins=/home/matiab/1MB462_GenomeAnalysis/04_Binning/Bins
Database=/proj/uppmax2024-2-7/Genome_Analysis/conda_envs/SGB/phylophlan_databases

# Create new Bin Directory 

mkdir $Output/Bins
mkdir $Output/Results

for n in 5 12 16 29
do
cp $Bins/Bins_${n}.fa $Output/Bins
done
cd $Output

# Create config file

phylophlan_write_default_configs.sh $Output

# Create Phylogenetic Tree

phylophlan \
-i $Output/Bins \
--output_folder $Output/Results \
-d phylophlan \
--genome_extension fa \
-f $Output/supermatrix_nt.cfg \
--nproc 2 \
--diversity high

# Run phylophlan_assign_sgbs 

phylophlan_assign_sgbs \
-i $Output/Bins \
--nproc 2 \
-n 1 \
-d $Database/SGB.Jan21 \
--database_folder $Database
