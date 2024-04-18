#!/bin/bash -l
#SBATCH -A uppmax2024-2-7 
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 02:00:00
#SBATCH -J Analysis_of_Expression
#SBATCH --mail-type=ALL
#SBATCH --mail-user matias.becker-burgos.1399@student.uu.se


# Load modules
module load bioinfo-tools
module load htseq
module load samtools

# Path of files to iterate

Bins_Annotation=/home/matiab/1MB462_GenomeAnalysis/05_Annotation

Mapped_RNA=/home/matiab/1MB462_GenomeAnalysis/06_Analysis_of_Expression/RNA_Mapping

Output=/home/matiab/1MB462_GenomeAnalysis/06_Analysis_of_Expression

# Create New directory

mkdir ~/1MB462_GenomeAnalysis/06_Analysis_of_Expression/Read_Count


# Run the Read counting Htseq

for x in Bins_5 Bins_12 Bins_16 Bins_29 ; do

samtools index -M $Mapped_RNA/${x}.fa_D1.bam $Mapped_RNA/${x}.fa_D3.bam
htseq-count -f bam -r pos -t CDS -i ID --stranded=no $Mapped_RNA/${x}.fa_D1.bam <( sed '/##FASTA/,$d' $Bins_Annotation/${x}/${x}.gff) > $Output/Read_Count/${x}_D1_count.txt
htseq-count -f bam -r pos -t CDS -i ID --stranded=no $Mapped_RNA/${x}.fa_D3.bam <( sed '/##FASTA/,$d' $Bins_Annotation/${x}/${x}.gff) > $Output/Read_Count/${x}_D3_count.txt

done

