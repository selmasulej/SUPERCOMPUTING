# Assignment 5
# Selma Sulejmanovic
# 3.4.26


---

# Objectives

- Work with file paths and environment variables
- Install and run a command-line tool (`fastp`)
- Write a Bash script that downloads and prepares FASTQ data
- Write a Bash script that performs trimming on sequencing reads
- Build a pipeline that runs scripts automatically for multiple files
- Inspect sequence data before/after trimming

---

# Project Structure

```
assignment_5/
├── pipeline.sh
├── README.md
├── scripts/
│   ├── 01_download_data.sh
│   └── 02_run_fastp.sh
├── data/
│   ├── raw/
│   └── trimmed/
└── log/
```

- `scripts/` contains the pipeline scripts
- `data/raw/` stores downloaded FASTQ files
- `data/trimmed/` stores trimmed reads
- `log/` contains fastp HTML reports

---

# Scripts

## 01_download_data.sh

This script downloads and prepares the FASTQ dataset:

1. Download the FASTQ tarball
2. Extract the contents
3. Move all `.fastq.gz` files into `data/raw/`
4. Remove the tarball and temp extracted folder

This script allows the data to be recreated automatically whenever the pipeline is run.

---

## 02_run_fastp.sh

This script performs trimming and filtering using fastp for a single paired-end sample.

The script takes one argument:

```
./scripts/02_run_fastp.sh data/raw/sample_R1.fastq.gz
```

From this forward read filename the script derives:

- The reverse read filename (`_R2_`)
- Output filenames for trimmed reads
- The HTML report filename

### Paired-End Reads

Sequencing was performed using paired-end sequencing, which produces two reads for each:

- **R1** = forward read
- **R2** = reverse read

The script derives the reverse read filename usinh:

```
REV_IN=${FWD_IN/_R1_/_R2_}
```

---

# fastp Parameters Used

The script runs fastp with the following parameters:

```
--in1                forward read input
--in2                reverse read input
--out1               forward trimmed output
--out2               reverse trimmed output
--json /dev/null     discard JSON report
--html ./log/...     write HTML report

--trim_front1 8
--trim_front2 8
--trim_tail1 20
--trim_tail2 20

--n_base_limit 0
--length_required 100
--average_qual 20
```

These parameters remove "low-quality" bases and filter out "poor-quality" reads.

---

# Installing fastp

The `fastp` binary was downloaded and placed in the directory:

```
~/programs/fastp
```

The directory was added to `$PATH` so that the program can be run from anywhere:

```
export PATH=$HOME/programs:$PATH
```

Version used:

```
fastp 1.1.0
```

---

# Pipeline Script

The `pipeline.sh` script runs the full workflow:

1. Run the download script
2. Loop through all forward reads in `data/raw`
3. Run `02_run_fastp.sh` on each sample


This allows the entire analysis to be reproduced with one command.

---

# Running the Pipeline

From the assignment directory:

```
cd ~/SUPERCOMPUTING/assignments/assignment_5
chmod +x pipeline.sh scripts/*.sh
./pipeline.sh
```

The pipeline will:

1. Download sequencing data
2. Process every paired-end sample using fastp
3. Save trimmed reads in `data/trimmed`
4. Generate reports in `log/`

---

# [Optional but for my own  better understanding] Verifying the Results

Check the number of input samples:

```
ls data/raw/*_R1_*.fastq.gz | wc -l
```
Expected:

```
196
```

Check trimmed output files:

```
ls data/trimmed/*trimmed.fastq.gz | wc -l
```

Expected:

```
392
```

(two trimmed reads for each paired sample)

Check HTML reports:

```
ls log/*.html | wc -l
```

Expected:

```
~196
```

---

# Reproducibility Test

To confirm the pipeline rebuilds everything correctly:

```
rm -f data/raw/*.fastq.gz
rm -f data/trimmed/*.fastq.gz
rm -f log/*.html

./pipeline.sh
```

The pipeline automatically downloads the data again and regenerates all outputs.

---

# Reflection

## Challenges

A challenge I had in particular was with task two; I initially tried to write "mv fastq_examples/*.fastq.gz data/raw/", which gave me an error because the .fast.qz files were extracted to my directory NOT inside "fastq(underscore)examples/". So, it failed because that folder/path didn't exist with those files. I did also find myself a bit confused with the parameters and usages of fastp, but the documentation helped. 

---

## New Things I Learned

- write modular Bash scripts
- automate repetitive tasks using loops
- install/configure command-line tools
- build reproducible data processing pipelines

---

## Why the Pipeline Uses Multiple Scripts

The workflow was split into smaller scripts so each script performs a single task:

- downloading data ('01_download_data.sh')
- processing a single sample ('02_run_fastp.sh')

The pipeline script will coordinate these tasks. It generally makes the workflow easier to test, debug, and reuse.

---

## Pros

- Easier debugging
- Scripts can be reused (in other projects)
- Fully reproducible workflow
- Large datasets can be processed automatically

---

## Cons

- Requires a lot more of careful management of file paths
- Can be  more complex than a single script
- More files to maintain

---

