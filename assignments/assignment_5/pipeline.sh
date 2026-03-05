#!/bin/bash
set -euo pipefail

# main project directory
MAIN_DIR=${HOME}/SUPERCOMPUTING/assignments/assignment_5
DATA_DIR=${MAIN_DIR}/data
SCRIPTS_DIR=${MAIN_DIR}/scripts

# move to project directory
cd ${MAIN_DIR}

# download sequencing data
echo "Downloading data..."
${SCRIPTS_DIR}/01_download_data.sh

# run fastp trimming on all samples
echo "Running fastp on all samples..."

for FWD in ${DATA_DIR}/raw/*_R1_*.fastq.gz
do
    ${SCRIPTS_DIR}/02_run_fastp.sh ${FWD}
done

echo "Pipeline complete."
