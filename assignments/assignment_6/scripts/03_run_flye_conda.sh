#!/bin/bash
set -euo pipefail

# start 
cd "$(dirname "$0")/.."

# load conda
module load miniforge3
source "$(conda info --base)/etc/profile.d/conda.sh"

# activate Flye environment
conda activate flye-env

# and make sure it is clean
rm -rf assemblies/assembly_conda
# output directory
mkdir -p assemblies/assembly_conda

# run Flye (help docu.)
flye \
  --nano-hq data/SRR33939694.fastq.gz \
  --out-dir assemblies/assembly_conda \
  --genome-size 50k \
  --threads 6 \
  --meta

# rename files to keep and delete everything else
mv assemblies/assembly_conda/assembly.fasta ./conda_assembly.fasta
mv assemblies/assembly_conda/flye.log ./conda_flye.log

rm -rf assemblies/assembly_conda
mkdir -p assemblies/assembly_conda

mv ./conda_assembly.fasta assemblies/assembly_conda/
mv ./conda_flye.log assemblies/assembly_conda/


# leave
conda deactivate
