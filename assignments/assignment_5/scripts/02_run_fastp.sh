#!/bin/bash
set -euo pipefail

FWD_IN=$1
REV_IN=${FWD_IN/_R1_/_R2_}

# forward/reverse output names
FWD_OUT=${FWD_IN/.fastq.gz/.trimmed.fastq.gz}
REV_OUT=${REV_IN/.fastq.gz/.trimmed.fastq.gz}

# put outputs in data/trimmed
FWD_OUT=${FWD_OUT/raw/trimmed}
REV_OUT=${REV_OUT/raw/trimmed}

# log dir + sample id
MAIN_DIR=${HOME}/SUPERCOMPUTING/assignments/assignment_5
LOG_DIR=${MAIN_DIR}/log
mkdir -p ${LOG_DIR}

mkdir -p $(dirname ${FWD_OUT})

SAMPLE=$(basename ${FWD_IN})
SAMPLE=${SAMPLE%%_R1_*}

fastp \
  --in1 ${FWD_IN} \
  --in2 ${REV_IN} \
  --out1 ${FWD_OUT} \
  --out2 ${REV_OUT} \
  --json /dev/null \
  --html ${LOG_DIR}/${SAMPLE}.html \
  --trim_front1 8 \
  --trim_front2 8 \
  --trim_tail1 20 \
  --trim_tail2 20 \
  --n_base_limit 0 \
  --length_required 100 \
  --average_qual 20
