#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status
set -x  # Print commands and their arguments as they are executed

# Create a conda environment for psi4
conda create -y -n forte python=3.10
conda activate forte

# Install dependencies
sudo apt-get update
sudo apt-get install -y cmake g++ git libblas-dev liblapack-dev libboost-all-dev \
    libeigen3-dev libint-dev libxc-dev libhdf5-dev libxml2-dev \
    libopenblas-dev libfftw3-dev

# Clone the Psi4 repo
git clone --recursive https://github.com/psi4/psi4.git
cd psi4

# Create build directory
mkdir objdir
cd objdir

# Build
cmake -DCMAKE_INSTALL_PREFIX=$HOME/psi4-install -DCMAKE_BUILD_TYPE=Release ..
make -j$(nproc)
make install

# Add Psi4 to PATH (optional)
echo 'export PATH=$HOME/psi4-install/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=$HOME/psi4-install/lib:$LD_LIBRARY_PATH' >> ~/.bashrc
