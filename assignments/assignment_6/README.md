ASSIGNMENT 6
Selma Sulejmanovic
3.18.26 

## Objectives
- Work with file paths & environment variables 
- Install & run Flye with multiple environments
- Build a reproducible pipeline and create bash scripts
- Compare results across different environments

---

## Project Structure

assignment_6/ 
├── pipeline.sh 
├── README.md 
├── flye-env.yml 
├── scripts/ 
│   ├── 01_download_data.sh 
│   ├── 02_flye_2.9.6_manual_build.sh 
│   ├── 02_flye_2.9.6_conda_install.sh 
│   ├── 03_run_flye_conda.sh 
│   ├── 03_run_flye_module.sh 
│   └── 03_run_flye_local.sh 
├── data/ 
│   └── SRR33939694.fastq.gz 
└── assemblies/ 
    ├── assembly_conda/  
    │   ├── conda_assembly.fasta  
    │   └── conda_flye.log  
    ├── assembly_module/  
    │   ├── module_assembly.fasta  
    │   └── module_flye.log  
    └── assembly_local/  
        ├── local_assembly.fasta  
        └── local_flye.log  

- scripts/ contains all pipeline scripts 
- data/ stores the downloaded FASTQ file (but ignored through .gitignore)
- assemblies/ stores the final outputs
- pipeline.sh runs all 
- flye-env.yml stores the conda environment 

---

## What I Did

In assignment 6, I built a reproducible assembly pipeline using Flye.  
It was run in three environments:

- conda 
- module 
- local build 

I intended to achieve the same results across the three.

---

## Scripts

### 01_download_data.sh
Downloads the dataset using wget and places it into:
data/SRR33939694.fastq.gz 

This means the data can be recreated automatically when the pipeline is rerun.

---

### 02_flye_2.9.6_manual_build.sh
Builds Flye locally by:
- moving to ~/programs/ 
- removes any old copy
- cloning the Flye repository 
- compiling it using make 

It is stored in:
~/programs/Flye/bin 

---

### 02_flye_2.9.6_conda_install.sh
Installs Flye using conda.

Utilized from lesson notes:

module load miniforge3 
source "$(conda info --base)/etc/profile.d/conda.sh" 
mamba used here:
mamba create -y -n flye-env flye=2.9.6 -c bioconda -c conda-forge 
conda used here:
conda activate flye-env 
flye --version 
conda deactivate 

The environment is exported to:
flye-env.yml

---

### 03_run_flye_conda.sh
Runs Flye using the conda environment.

- activates flye-env 
- runs Flye 
- outputs to assemblies/assembly_conda/ 
- renames files 
- removes extra files 

---

### 03_run_flye_module.sh
Runs Flye using the HPC module (similar setup as previous script):

module load Flye/gcc-11.4.1/2.9.6 

Outputs to:
assemblies/assembly_module/ 

---

### 03_run_flye_local.sh
Runs Flye using the locally built version (similar setup as previous script):

export PATH="$HOME/programs/Flye/bin:$PATH" 

Outputs to:
assemblies/assembly_local/ 

---

## Flye Command Used

flye \
  --nano-hq data/SRR33939694.fastq.gz \
  --out-dir assemblies/assembly_conda \
  --genome-size 50k \
  --threads 6 \
  --meta 

Reasoning (via help docu.):
- nano-hq: high-quality nanopore reads 
- genome-size 50k: phage estimate 
- threads 6: max 
- meta: multiple genomes possible

---

## Pipeline Script

pipeline.sh runs:

bash scripts/01_download_data.sh 
bash scripts/02_flye_2.9.6_manual_build.sh 
bash scripts/02_flye_2.9.6_conda_install.sh 
bash scripts/03_run_flye_conda.sh 
bash scripts/03_run_flye_module.sh 
bash scripts/03_run_flye_local.sh 

Then prints (last 10 lines of each file):

tail -n 10 assemblies/assembly_conda/conda_flye.log 
tail -n 10 assemblies/assembly_module/module_flye.log 
tail -n 10 assemblies/assembly_local/local_flye.log 

---

## Running the Pipeline

cd ~/SUPERCOMPUTING/assignments/assignment_6 
chmod +x pipeline.sh scripts/*.sh 
./pipeline.sh 

---

## Output

Final files:

assemblies/assembly_conda/conda_assembly.fasta 
assemblies/assembly_conda/conda_flye.log 
assemblies/assembly_module/module_assembly.fasta 
assemblies/assembly_module/module_flye.log 
assemblies/assembly_local/local_assembly.fasta 
assemblies/assembly_local/local_flye.log 

Each folder contains only the final assembly and log file.

---

## Results

Command used:

echo "CONDA" 
tail -n 10 assemblies/assembly_conda/conda_flye.log 

echo "MODULE"
tail -n 10 assemblies/assembly_module/module_flye.log 

echo "LOCAL" 
tail -n 10 assemblies/assembly_local/local_flye.log 

All results were the same:

- Total length: 91713 
- Fragments: 2 
- N50: 47428 
- Mean coverage: 422 

---

## Reproducibility Test

rm -rf data assemblies 
./pipeline.sh 

The pipeline rebuilds everything from scratch.

---

## Reflection

### Challenges
The only true challenge that took some trial and error was with Task 6. I had issues with getting rid of other directories that showed up. For example, on 6A, I had an output that included '00-assembly', '10-consensus', '20-repeat', '30-contigger', and '40-polishing'. 

### New Things I Learned
- managing environments (conda, module, local) 
- using PATH for local tools 
- writing reproducible pipelines for these environments 

### Thoughts on Methods

Conda:
- easiest to reproduce (using '.yml') 
- straightforward to activate and run
- works on HPC, my laptop, someone else's machine, etc.

Module:
- simple to use on HPC since it is installed
- easy to set up ('moduule load')
- it may depend on which system is being used

Local build:
- needs more setup and manual work (e.g. managing PATH), so may be more difficult to reproduce
- pretty flexible
- useful if a module is not available

### Preference
I prefer the conda method because it is easiest to manage, work across machines/systems, and reproduce.

### Next Time
I would use conda first, then module, then local build (if needed).
