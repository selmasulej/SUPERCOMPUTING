#!/bin/bash
set -ueo pipefail

# set project directory
MAIN_DIR="${HOME}/SUPERCOMPUTING/assignments/assignment_5"

# go there
cd ${MAIN_DIR}

# make raw data directory
mkdir -p data/raw

# download tarball
wget https://gzahn.github.io/data/fastq_examples.tar

# extract files
tar -xf fastq_examples.tar

# move fastq files into raw folder
mv *.fastq.gz data/raw/

# remove tarball
rm -f  fastq_examples.tar
