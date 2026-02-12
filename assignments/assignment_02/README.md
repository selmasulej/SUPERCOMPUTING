# Assignment 02 – HPC Access & Remote File Transfer

Full Name: Selma Sulejmanovic 
Date: February 11, 2026
Assignment Number: 02

## Overview

- Create a reproducible project directory on the HPC
- Retrieve genomic data (using command-line FTP)
- Transfer files (using SFTP)
- Inspect file permissions
- Verify file integrityz (using MD5 hashes)
- Create bash aliases for efficiency

## Task 1 – HPC Workspace Setup 

(HPC)

Connected to cluster:
ssh ssulejmanovic@bora.sciclone.wm.edu

Verified directory:
ls -R ~/SUPERCOMPUTING/assignments/assignment_02/

Created directory if needed:
mkdir -p ~/SUPERCOMPUTING/assignments/assignment_02/data/

## Task 2 – Download Files via Command-Line FTP

(Local Machine)

The ftp command was not available on my macOS.

Installed FTP utilities:
brew install inetutils

Connected to NCBI:
ftp ftp.ncbi.nlm.nih.gov

Connected to NCBI:
ftp ftp.ncbi.nlm.nih.gov

Login:
Username: anonymous
Password: <W&M email address>

Navigated to directory:
cd genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/
ls

Switched to binary mode:
binary

Downloaded files:
get GCF_000005845.2_ASM584v2_genomic.fna.gz
get GCF_000005845.2_ASM584v2_genomic.gff.gz

Exited session:
bye

Verified local download:
ls

## Task 3 – File Transfer and Permissions

### 3.1 Transfer via SFTP (FileZilla)

(Local to  HPC)

Connected using:
Host: bora.sciclone.wm.edu
Protocol: SFTP
Port: 22

Uploaded both .gz files to:
~/SUPERCOMPUTING/assignments/assignment_02/data/

Verified on HPC:
ls ~/SUPERCOMPUTING/assignments/assignment_02/data/

### 3.2 Ensure Files Are World-Readable

(HPC)

Checked permissions:
cd ~/SUPERCOMPUTING/assignments/assignment_02/data/
ls -l

Initial permissions:
-rw-r-----

Modified permissions:
chmod 644 *.gz

Verified updated permissions:
ls -l

Final permissions:
-rw-r--r--

Files are now readable by all users.

## Task 4 – Verify File Integrity (MD5)

(Local Machine)

md5 GCF_000005845.2_ASM584v2_genomic.fna.gz
md5 GCF_000005845.2_ASM584v2_genomic.gff.gz

Results:

<c13d459b5caa702ff7e1f26fe44b8ad7> GCF_000005845.2_ASM584v2_genomic.fna.gz 
<2238238dd39e11329547d26ab138be41> GCF_000005845.2_ASM584v2_genomic.gff.gz 

(HPC)

cd ~/SUPERCOMPUTING/assignments/assignment_02/data/
md5sum *.gz

Results:

<c13d459b5caa702ff7e1f26fe44b8ad7> GCF_000005845.2_ASM584v2_genomic.fna.gz
<2238238dd39e11329547d26ab138be41> GCF_000005845.2_ASM584v2_genomic.gff.gz 

Verification:

The MD5 hashes from the local machine and the HPC matched exactly, meaning there was no corruption during transfer.

## Task 5 – Create Useful Bash Aliases

(HPC)

Added the following to ~/.bashrc:

alias u='cd ..;clear;pwd;ls -alFh --group-directories-first'
alias d='cd -;clear;pwd;ls -alFh --group-directories-first'
alias ll='ls -alFh --group-directories-first'

Activated with:
source ~/.bashrc

Verified using:
alias

ll
Displays a directory listing that first  includes hidden files, permissions, file sizes, etc.

u
Moves up one directory, clears the screen, prints the current directory.

d
Returns to the previous directory, clears the screen, prints the current directory.

## Reflection

Assingment two strengthened by ability to securely and effectively work across a local and HPC environment. Some troubles came about, such as with installing some FTP utilities and having many login timeouts, but with some research and persistence, I was able to grasp the systems. Managing Unix permissions highlighted the importance in making sure accessibility is available for all; the MD5 verfication was notably interesting in that it reinforced the significance behind validating data integrity (as opposed to just assuming). Generally speaking, keeping up with a balanced workflow when navigating between local and remote systems had me feeling slightly overwhemled, but it allowed me to improve in working in an HPC setting. What I'd personally change next time, however, is being more organized (less tabs open, using some type of text editor to keep code updated, etc).
