#!/bin/bash
set -euo pipefail

# similar as 6A and 6B (local build this time)
cd "$(dirname "$0")/.."

# where Flye was built in
export PATH="$HOME/programs/Flye/bin:$PATH"

rm -rf assemblies/assembly_local
mkdir -p assemblies/assembly_local

flye \
  --nano-hq data/SRR33939694.fastq.gz \
  --out-dir assemblies/assembly_local \
  --genome-size 50k \
  --threads 6 \
  --meta

mv assemblies/assembly_local/assembly.fasta ./local_assembly.fasta
mv assemblies/assembly_local/flye.log ./local_flye.log

rm -rf assemblies/assembly_local
mkdir -p assemblies/assembly_local

mv ./local_assembly.fasta assemblies/assembly_local/
mv ./local_flye.log assemblies/assembly_local/
