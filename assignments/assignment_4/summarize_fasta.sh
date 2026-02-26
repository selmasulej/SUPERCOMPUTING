#!/bin/bash
set -ueo pipefail

fasta=$1

seq_info=$(seqtk comp "$fasta")

num_seqs=$(echo "$seq_info" | wc -l | cut -f1 -d " ")

total_nt=0
while read line
do
    length=$(echo "$line" | cut -f2)
    total_nt=$((total_nt + length))
done <<< "$seq_info"

echo "Summary for FASTA file: $fasta"
echo "Total sequences: $num_seqs"
echo "Total nucleotides: $total_nt"
echo ""
echo "Sequence names and lengths:"
echo "$seq_info" | cut -f1,2
