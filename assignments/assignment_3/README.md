# Assignment 3

Selma Sulejmanovic
SUPERCOMPUTING
FebruarY 18 2026

---

## Assignment Overview

This assignment explored working with genomic FASTA files using Unix command-li>

• stream redirection and pipes
• text processing tools (grep, wc, sort, tr, paste)
• navigating directories and organizing files
• summarizing biological sequence data

---

## Directory Structure

assignment_3/
├── README.md
├── tair10.tsv
└── data/
    └── GCF_000001735.4_TAIR10.1_genomic.fna

---

## Task 1 — Setup directory structure

cd ~/SUPERCOMPUTING/assignments
mkdir -p assignment_3/data
cd assignment_3
touch README.md

---

## Task 2 — Download genome file

cd ~/SUPERCOMPUTING/assignments/assignment_3/data

wget https://gzahn.github.io/data/GCF_000001735.4_TAIR10.1_genomic.fna.gz

gunzip GCF_000001735.4_TAIR10.1_genomic.fna.gz

---

## Task 3 — Genome Inspection & Analysis

Return to assignment directory:

cd ~/SUPERCOMPUTING/assignments/assignment_3

---

### 1. Count total sequences (headers)

grep -c "^>" data/GCF_000001735.4_TAIR10.1_genomic.fna

Expected output: 7

---

### 2. Count total nucleotides (exclude headers & newlines)

grep -v "^>" data/GCF_000001735.4_TAIR10.1_genomic.fna | tr -d "\n" | wc -c

Expected output: 119668634

---

### 3. Count total lines in file

wc -l data/GCF_000001735.4_TAIR10.1_genomic.fna

Expected output: 14

---

### 4. Count header lines containing “mitochondrion”

grep "^>" data/GCF_000001735.4_TAIR10.1_genomic.fna | grep -c "mitochondrion"

Expected output: 1

---

### 5. Count header lines containing “chromosome”

grep "^>" data/GCF_000001735.4_TAIR10.1_genomic.fna | grep -c "chromosome"

Expected output: 5

---

### 6. Count nucleotides in chromosomes 1–3

Find header line numbers:

grep -n "chromosome 2" data/GCF_000001735.4_TAIR10.1_genomic.fna
grep -n "chromosome 3" data/GCF_000001735.4_TAIR10.1_genomic.fna

Chromosome 1 (header line 1 → sequence line 2)

tail -n +2 data/GCF_000001735.4_TAIR10.1_genomic.fna | head -n 1 | tr -d "\n" |>

Expected: 30427672

Chromosome 2 (header line 3 → sequence line 4)

tail -n +4 data/GCF_000001735.4_TAIR10.1_genomic.fna | head -n 1 | tr -d "\n" |>

Expected: 19698290

Chromosome 3 (header line 5 → sequence line 6)

tail -n +6 data/GCF_000001735.4_TAIR10.1_genomic.fna | head -n 1 | tr -d "\n" |>

Expected: 23459831

---

### 7. Count nucleotides in chromosome 5

Find header:

grep -n "chromosome 5" data/GCF_000001735.4_TAIR10.1_genomic.fna

Chromosome 5 (header line 9 → sequence line 10)

tail -n +10 data/GCF_000001735.4_TAIR10.1_genomic.fna | head -n 1 | tr -d "\n" >

Expected: 26975503

---

### 8. Count sequences containing long A stretch

grep -c "AAAAAAAAAAAAAAA" data/GCF_000001735.4_TAIR10.1_genomic.fna

Expected: 1

---

### 9. Alphabetically first header

grep "^>" data/GCF_000001735.4_TAIR10.1_genomic.fna | sort | head -n 1

Expected result begins with:
>NC_000932.1

---

### 10. Create tab-separated file of headers and sequences

paste <(grep "^>" data/GCF_000001735.4_TAIR10.1_genomic.fna) <(grep -v "^>" dat>

Verify tab separation:

cat -T tair10.tsv | head

---

## Notes

• FASTA files store DNA sequences; headers begin with >
• Pipes (|) pass output from one command to another

---

## Reflection:

Assignment three strengthened my confidence in using command-line tools and better understand how it can be used to efficiently summarize biological data. My approach was to breaking things down to manageable pieces that allowed me to reference the lesson notes. For the reason that FASTA files have a particular format in which they begin with “>”, it was much easier to use the Unix pipelines learnt in class so far to extract the necessary information. Grep, wc, tr, head, and tail are examples of tools that allowed me count and filter the data. Arguably the most valuable point taken from assignment three was the significance of pipelines. Without any fancy specialized software, I was able to remove header lines, count the nucleotides, isolate certain patterns, and more with just the pipelines. It was extraordinary to see how in just a few commands, I was able to see an output of millions of nucleotides. The paste command particularly both surprised and frustrated me with its simplicity. It allowed me to transform the format of the FASTA file by separating it with tabs. At first, I was puzzled with the formatting of the output. I therefore used cat -T to verify that the tabs truly exist. It ultimately reinforced my understanding of the command, how it appears in the terminal (as spaces), and overall, how commands help to efficiently navigate text files. All these skills learnt thus far are crucial in computational work due to datasets often being very large. Command-line tools permit quick processing and coherent reproducibility. Researchers are able to work directly with raw data to create an adaptable workflow by utilizing pipes and streams. The way I may add about automating my solution could be creating a script that would perform the analyzes I’ve done and outputs I’ve called to be written in a single report. Variables could be used, and it would generally reduce manual errors as well as create better reproducibility. 
