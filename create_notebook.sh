#!/bin/bash

set -e

sudo -u ec2-user -i <<EOF

echo ". /home/ec2-user/anaconda3/etc/profile.d/conda.sh" >> ~/.bashrc

# Create custom conda environment
conda env create -f https://raw.githubusercontent.com/parkererickson/tg-sagemaker-test/main/environment.yml

# Activate our freshly created environment
source /home/ec2-user/anaconda3/bin/activate tigergraph-ml

# Expose environment as kernel
python -m ipykernel install --user --name tigergraph-ml --display-name TigerGraph-ML

# Deactivate environment
source /home/ec2-user/anaconda3/bin/deactivate

EOF




#!/bin/bash

set -e

# OVERVIEW
# This script installs a custom, persistent installation of conda on the Notebook Instance's EBS volume, and ensures
# that these custom environments are available as kernels in Jupyter.
# 
# The on-create script downloads and installs a custom conda installation to the EBS volume via Miniconda. Any relevant
# packages can be installed here.
#   1. ipykernel is installed to ensure that the custom environment can be used as a Jupyter kernel   
#   2. Ensure the Notebook Instance has internet connectivity to download the Miniconda installer


sudo -u ec2-user -i <<'EOF'
unset SUDO_UID
# Install a separate conda installation via Miniconda
WORKING_DIR=/home/ec2-user/SageMaker/custom-miniconda
mkdir -p "$WORKING_DIR"
wget https://repo.anaconda.com/miniconda/Miniconda3-4.6.14-Linux-x86_64.sh -O "$WORKING_DIR/miniconda.sh"
bash "$WORKING_DIR/miniconda.sh" -b -u -p "$WORKING_DIR/miniconda" 
rm -rf "$WORKING_DIR/miniconda.sh"
# Create a custom conda environment
source "$WORKING_DIR/miniconda/bin/activate"
conda env create -f https://raw.githubusercontent.com/parkererickson/tg-sagemaker-test/main/environment.yml
conda activate "tigergraph-ml-pyg"
pip install --quiet ipykernel
# Customize these lines as necessary to install the required packages
EOF