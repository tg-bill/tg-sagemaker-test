#!/bin/bash

set -e

# OVERVIEW
# This script creates and configures the env_tf210_p36 environment.

sudo -u ec2-user -i <<EOF

echo ". /home/ec2-user/anaconda3/etc/profile.d/conda.sh" >> ~/.bashrc

# Create custom conda environment
conda create -f 

# Activate our freshly created environment
source /home/ec2-user/anaconda3/bin/activate env_tf210_p36

# Install git-repository dependencies
pip install -q git+https://github.com/tensorflow/examples.git

# Expose environment as kernel
python -m ipykernel install --user --name env_tf210_p36 --display-name My_Env_tf_2.1.0_py_3.6

# Deactivate environment
source /home/ec2-user/anaconda3/bin/deactivate

EOF