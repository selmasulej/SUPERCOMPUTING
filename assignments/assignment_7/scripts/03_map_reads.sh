#!/bin/bash
set -ueo pipefail

# Loop through all cleaned forward reads
for CLEAN_FWD in ./data/clean/*_1.clean.fastq.gz
do
# Define corresponding reverse read file
    CLEAN_REV="${CLEAN_FWD/_1.clean.fastq.gz/_2.clean.fastq.gz}"
 # Extract sample name
    SAMPLE=$(basename "${CLEAN_FWD}" _1.clean.fastq.gz)
# Define output SAM file
    SAM_OUT="./output/${SAMPLE}.sam"
 # Define filtered (mapped-only) SAM output
    MAPPED_OUT="./output/${SAMPLE}.mapped.sam"
 # Check if mapping already completed
    if [[ -s "${SAM_OUT}" && -s "${MAPPED_OUT}" ]]; then
        echo "Skipping mapping: ${SAMPLE} already mapped"
        continue
    fi

    echo "Mapping reads for ${SAMPLE}"
# Run BBMap to align reads to the dog reference genome
    bbmap.sh \
        -Xmx16g \
        ref=./data/dog_reference/dog_reference_genome.fna \
        in1="${CLEAN_FWD}" \
        in2="${CLEAN_REV}" \
        out="${SAM_OUT}" \
        minid=0.95
# Filter to keep only mapped reads (remove unmapped reads)
    samtools view -F 4 "${SAM_OUT}" > "${MAPPED_OUT}"
done
