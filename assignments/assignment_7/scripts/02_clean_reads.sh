#!/bin/bash
set -ueo pipefail

# Loop through all forward read FASTQ files
for RAW_FWD in ./data/raw/*_1.fastq.gz
do
# Define corresponding reverse read file
    RAW_REV="${RAW_FWD/_1.fastq.gz/_2.fastq.gz}"
 # Extract sample name from file path
    SAMPLE=$(basename "${RAW_FWD}" _1.fastq.gz)
# Define output cleaned file names
    CLEAN_FWD="./data/clean/${SAMPLE}_1.clean.fastq.gz"
    CLEAN_REV="./data/clean/${SAMPLE}_2.clean.fastq.gz"
# Check if cleaned files already exist to avoid reprocessing
    if [[ -s "${CLEAN_FWD}" && -s "${CLEAN_REV}" ]]; then
        echo "Skipping cleaning: cleaned FASTQ files already exist for ${SAMPLE}"
    else
        echo "Cleaning reads for ${SAMPLE}"
# Run fastp for quality control and filtering
        fastp \
            -i "${RAW_FWD}" \
            -I "${RAW_REV}" \
            -o "${CLEAN_FWD}" \
            -O "${CLEAN_REV}"
    fi
done
