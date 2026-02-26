Assignment 4 — Bash Scripts and Program PATHs
Name: Selma Sulejmanovic
Date: 2-25-26


----------------------------------------
Installing Programs (Tasks 1–6)
----------------------------------------

Created a personal software directory:

    mkdir ~/programs

Downloaded and extracted GitHub CLI (gh):

    wget https://github.com/cli/cli/releases/download/v2.74.2/gh_2.74.2_linux_amd64.tar.gz
    tar -xzvf gh_2.74.2_linux_amd64.tar.gz

Created installation script:

    nano ~/programs/install_gh.sh
    chmod +x ~/programs/install_gh.sh

(Removed downloaded tarball after extraction)

    rm gh_2.74.2_linux_amd64.tar.gz

Added gh to PATH by editing ~/.bashrc:

    nano ~/.bashrc
    export PATH=$PATH:$HOME/programs/gh_2.74.2_linux_amd64/bin

Reloaded shell:

    exec bash

Verified installation:

    which gh
    gh --version

Authenticated GitHub:

    gh auth login
    gh auth status

---

Installed seqtk:

    cd ~/programs
    git clone https://github.com/lh3/seqtk.git
    cd seqtk
    make

Created installation script (using what was provided within the github page):

    nano ~/programs/install_seqtk.sh
    chmod +x ~/programs/install_seqtk.sh

Appended seqtk directory to PATH in ~/.bashrc:

    export PATH=$PATH:$HOME/programs/seqtk


Reloaded shell:

    exec bash

Verified:

    which seqtk

----------------------------------------
Figure out seqtk (Task 7)
----------------------------------------

Explored seqtk functionality using the FASTA file from Assignment 3:

    seqtk comp [fna] | head

This command displays sequence names and their lengths.

----------------------------------------
summarize_fasta.sh Script (Task 8)
----------------------------------------

Navigated to assignment directory:

    cd ~/SUPERCOMPUTING/assignments/assignment_4

Created the script:

    nano summarize_fasta.sh

Made it executable:

    chmod +x summarize_fasta.sh

The script:
• accepts a FASTA file as a positional argument  
• stores the filename in a variable  
• counts sequences  
• calculates total nucleotides  
• prints sequence names and lengths (table)

Ex:

    ./summarize_fasta.sh data/ecoli_K12.fna

----------------------------------------
Multiple FASTA Files (Task 9)
----------------------------------------

Created a data directory:

    mkdir data

Downloaded FASTA files from GenBank:

wget -O data/ecoli_K12.fna "https://www.ncbi.nlm.nih.gov/sviewer/viewer.fcgi?id=NC_000913.3&db=nuccore&report=fasta&retmode=text"

wget -O data/yeast_mito.fna "https://www.ncbi.nlm.nih.gov/sviewer/viewer.fcgi?id=NC_001224.1&db=nuccore&report=fasta&retmode=text"

wget -O data/human_mito.fna "https://www.ncbi.nlm.nih.gov/sviewer/viewer.fcgi?id=NC_012920.1&db=nuccore&report=fasta&retmode=text"

Processed all FASTA files using a for-loop and wildcard:

    for f in data/*.fna
    do
        ./summarize_fasta.sh "$f"
    done

Note: FASTA files are ignored by git using .gitignore (assignments/**/data/).

----------------------------------------
Directory Structure
----------------------------------------

assignments/assignment_4/
    summarize_fasta.sh
    README.md
    data/   (ignored by git)

Programs installed outside this directory:

    ~/programs/install_gh.sh
    ~/programs/install_seqtk.sh
    ~/programs/seqtk/
    ~/programs/gh_2.74.2_linux_amd64/

----------------------------------------
Reflection
----------------------------------------

Challenges:
Initially confused by task two’s simplicity, but I better understand now that it is because the link was given to us. In the real world, finding files aren’t always so direct. Additionally, I was confused about how the programs installed OUTSIDE of my assignment_4 directory would work (as in how it can be accessed on HPC by others). I also had trouble with task eight and writing the script (summarize_fasta.sh). I believe I was overcomplicating it at first, which is what caused some trial and error. 

New Skills Learned:
Though there was some trial and error, I did learn many new things:
• Installing software without administrator privileges
• Writing reusable Bash scripts
• Using loops for automation
• Processing FASTA data using command-line tools

What is $PATH and how is it used?:
PATH is a variable that lists directories that the shell searches when a command is entered. By adding a directory/location to PATH, programs in that directory/location can be run from anywhere without typing the full path.
