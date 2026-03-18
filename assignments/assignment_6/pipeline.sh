#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

bash scripts/01_download_data.sh
bash scripts/02_flye_2.9.6_manual_build.sh
bash scripts/02_flye_2.9.6_conda_install.sh
bash scripts/03_run_flye_conda.sh
bash scripts/03_run_flye_module.sh
bash scripts/03_run_flye_local.sh

# Task 7 (last 10 lines of each file)
echo "CONDA"
tail -n 10 assemblies/assembly_conda/conda_flye.log

echo "MODULE"
tail -n 10 assemblies/assembly_module/module_flye.log

echo "LOCAL"
tail -n 10 assemblies/assembly_local/local_flye.log
