# Assignment 7: Metagenomic Pipeline for Dog DNA Detection
## Selma Sulejmanovic
## 3.25.26

---

##  Overview

This project implements a pipeline that processes metagenomic sequencing data and detects the presence of dog DNA contamination. It automates downloading sequencing data, doing quality control, mapping reads to a dog reference genome, and extracting mapped reads.

## Data Selection

The sequencing data used in this project was obtained from the NCBI Sequence Read Archive (SRA).

### Search Criteria
The following filters were used to select samples:
- Searched: shotgun metagenome illumina 
- Filter: Illumina
- Filter: Genome

A total of 10 samples were selected for analysis.

### Metadata File
The metadata file containing the selected samples is located at:


---

## Project Structure

```md
assignment_7/
│
├── data/
│ ├── raw/ # Raw FASTQ files (gzipped)
│ ├── clean/ # Quality-controlled FASTQ files
│ ├── dog_reference/ # Dog genome reference files
│ └── SraRunTable.csv # Metadata file
│
├── output/ # SAM and mapped SAM outputs
│
├── scripts/
│ ├── 01_download_data.sh
│ ├── 02_clean_reads.sh
│ └── 03_map_reads.sh
│
├── assignment_7_pipeline.slurm
└── README.md


## Pipeline Description

The pipeline consists of three main scripts:

### Download and Prepare Data (`01_download_data.sh`)
- Downloads sequencing data using `fasterq-dump`
- Converts SRA files into FASTQ format
- Compresses FASTQ files using `gzip`
- Downloads and extracts the dog reference genome using `datasets`

---

### Quality Control (`02_clean_reads.sh`)
- Uses `fastp` to filter and clean sequencing reads
- Outputs cleaned FASTQ files to the `data/clean/` directory

---

###  Mapping and Extraction (`03_map_reads.sh`)
- Uses `bbmap` to align reads to the dog genome
- Uses `samtools` to extract only mapped reads
- Outputs:
  - `.sam` files (full alignments)
  - `.mapped.sam` files (dog-mapped reads only)

## How to Run the Pipeline

### Submit the SLURM job:

```bash
sbatch assignment_7_pipeline.slurm

### Monitor status:

```bash
squeue -u <your_username>

### Check the recent outputs:

```bash
tail -n 20 output/assignment7_*.out
tail -n 20 output/assignment7_*.err


## Software Requirements

The following tools must be installed and available in your `PATH`:

- samtools (v1.22.1)
- bbmap (v39.01)
- fastp (v1.1.0)
- fasterq-dump (SRA Toolkit v3.4.0)
- datasets (NCBI)

> Note: These tools were either loaded via modules or manually added to PATH in the SLURM script. Users must make sure these programs are installed before running the pipeline.

##  Results: Dog DNA Detection

| Sample ID    | Total QC Reads | Dog-Mapped Reads |
|--------------|----------------|------------------|
| SRR37767435  | 19,325,522     | 1,304            |
| SRR37767436  | 19,272,559     | 504              |

**Note:** Due to SLURM time constraints, only two samples completed the full pipeline. These results confirm that the workflow is functioning correctly.

### Interpretation

Both samples show a small number of reads mapping to the dog genome, suggesting low-level contamination.

## Reflection

### Challenges 

The first challenge I had was accidentally obtaining some non-SRA files (instead, err). That was an easy to fix to swap out. Secondly, I had small issues in making sure my SLURM script was able to utilize the software I installed. The biggest challenge, however, was something more general--working with such a large dataset. My dataset amounted to rough 102GB, which therefore required a significant amount of time for the gzipping and mapping. This is tthe first time I've worked with a dataset like this, so it was a surprise and worry at the same time. I underestimated the time; my SLURM time limit was 12 hours, and the pipeline exceeded that time limit. I was able to, however, at least get two mapped to compare. 

### What I Learned

- How to use SLURM for job scheduling
- The importance of writing scripts that can resume progress (like to skip files already downloaded, or already cleaned)
- How to manage large genomic datasets efficiently
- How tools like fastp, bbmap, and samtools work together
