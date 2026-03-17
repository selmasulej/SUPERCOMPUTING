#!/bin/bash
set -euo pipefail

# go to assignment root
cd "$(dirname "$0")/.."

# go to programs folder in home
mkdir -p ~/programs
cd ~/programs

# to rerun cleanly
rm -rf Flye

# clone Flye version 2.9.6
git clone --branch 2.9.6 https://github.com/mikolmogorov/Flye.git

cd Flye
make
