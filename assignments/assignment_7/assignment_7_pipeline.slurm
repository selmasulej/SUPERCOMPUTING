#!/bin/bash
#SBATCH --job-name=assignment7_pipeline
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=24:00:00
#SBATCH --mem=24G
#SBATCH -o /sciclone/home/ssulejmanovic/SUPERCOMPUTING/assignments/assignment_7/output/assignment7_%j.out
#SBATCH -e /sciclone/home/ssulejmanovic/SUPERCOMPUTING/assignments/assignment_7/output/assignment7_%j.err

set -ueo pipefail

cd /sciclone/home/ssulejmanovic/SUPERCOMPUTING/assignments/assignment_7

module load samtools/gcc-11.4.1/1.22.1
export PATH=$PATH:/sciclone/home/ssulejmanovic/programs/sratoolkit.3.4.0-ubuntu64/bin
export PATH=$PATH:/sciclone/home/ssulejmanovic/programs
export PATH=$PATH:/sciclone/home/ssulejmanovic/programs/bbmap

bash scripts/01_download_data.sh
bash scripts/02_clean_reads.sh
bash scripts/03_map_reads.sh
