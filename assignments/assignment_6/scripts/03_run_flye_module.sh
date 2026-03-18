#!/bin/bash
set -euo pipefail

# similar set up as 6A (using conda, now module env)
cd "$(dirname "$0")/.."

# Flye module
module load Flye/gcc-11.4.1/2.9.6

rm -rf assemblies/assembly_module
mkdir -p assemblies/assembly_module

flye \
  --nano-hq data/SRR33939694.fastq.gz \
  --out-dir assemblies/assembly_module \
  --genome-size 50k \
  --threads 6 \
  --meta

mv assemblies/assembly_module/assembly.fasta ./module_assembly.fasta
mv assemblies/assembly_module/flye.log ./module_flye.log

rm -rf assemblies/assembly_module
mkdir -p assemblies/assembly_module

mv ./module_assembly.fasta assemblies/assembly_module/
mv ./module_flye.log assemblies/assembly_module/
