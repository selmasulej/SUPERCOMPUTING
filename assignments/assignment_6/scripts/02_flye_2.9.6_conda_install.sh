#!/bin/bash
set -euo pipefail

# go to assignment root
cd "$(dirname "$0")/.."

# load conda from module
module load miniforge3

# initialize conda
source "$(conda info --base)/etc/profile.d/conda.sh"

# create environment (mamba)
mamba create -y -n flye-env flye=2.9.6 -c bioconda -c conda-forge

# activate environment (conda)
conda activate flye-env

# test Flye
flye --version

# export environment
conda env export --no-builds > flye-env.yml

# deactivate
conda deactivate
