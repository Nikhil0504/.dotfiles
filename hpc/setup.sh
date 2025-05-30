#!/usr/bin/env bash

# HPC specific setup script

echo "Setting up HPC specific configurations..."

# Create necessary directories
mkdir -p $HOME/.local/bin
mkdir -p $HOME/.config

# Install Miniconda if it doesn't exist
if [ ! -d "$HOME/miniconda3" ]; then
    echo "Installing Miniconda..."
    # Download the latest Miniconda installer
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh
    # Install Miniconda silently
    bash /tmp/miniconda.sh -b -p $HOME/miniconda3
    # Add to path for current session
    export PATH="$HOME/miniconda3/bin:$PATH"
    # Initialize conda for shell integration
    $HOME/miniconda3/bin/conda init zsh
fi

# Install essential Python packages
if command -v pip &> /dev/null; then
    echo "Installing essential Python packages..."
    pip install --user numpy scipy matplotlib pandas jupyterlab ipython
fi

echo "HPC setup complete!"
