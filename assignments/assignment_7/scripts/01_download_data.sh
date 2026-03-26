#!/bin/bash
set -ueo pipefail

# Loop through each accession ID from the metadata file (skip header row)
for ACCESSION in $(tail -n +2 ./data/SraRunTable.csv | cut -d',' -f1)
do
# Define expected output file names (forward and reverse reads)
    RAW_FWD="./data/raw/${ACCESSION}_1.fastq"
    RAW_REV="./data/raw/${ACCESSION}_2.fastq"
    RAW_FWD_GZ="./data/raw/${ACCESSION}_1.fastq.gz"
    RAW_REV_GZ="./data/raw/${ACCESSION}_2.fastq.gz"
# Check if either uncompressed OR compressed files already exist
    if [[ (-s "${RAW_FWD}" && -s "${RAW_REV}") || (-s "${RAW_FWD_GZ}" && -s "${RAW_REV_GZ}") ]]; then
        echo "Skipping download: FASTQ files already exist for ${ACCESSION}"
    else
        echo "Downloading FASTQ files for ${ACCESSION}"
# Download sequencing data and split into paired-end FASTQ files
        fasterq-dump "${ACCESSION}" --split-files --outdir ./data/raw
    fi
done

# Compress all FASTQ files
gzip -f ./data/raw/*.fastq
# Download dog reference genome
datasets download genome taxon "Canis familiaris" --reference --filename ./data/dog_reference/dog.zip
# Unzip the genome
unzip -o ./data/dog_reference/dog.zip -d ./data/dog_reference
# Find and copy the genome FASTA file to a standard location
find ./data/dog_reference -name "*.fna" -exec cp {} ./data/dog_reference/dog_reference_genome.fna \;
