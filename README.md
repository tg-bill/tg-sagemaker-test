# Graph Machine Learning with TigerGraph and AWS

## Setup TigerGraph Database
### Create EC2 Instance

### Install TigerGraph

### Install Graph Data Processing Service

## Setup SageMaker
### Create Lifecycle Configuration
The Lifecycle configuration defines commands that are run when the notebook instance is started. In this case, we will be installing the PyTorch Geometric and other TigerGraph dependencies. 

#### GPU Configuration
If you want a GPU instance to run your notebook, you need to edit the ```start_notebook.sh``` script to install the right dependencies. By changing the ```conda env create``` command to utilize the ```environment-gpu.yml``` file, instead of the ```environment-cpu.yml``` file. The resulting script is shown below.
```sh
#!/bin/bash

set -e

sudo -u ec2-user -i <<EOF

echo ". /home/ec2-user/anaconda3/etc/profile.d/conda.sh" >> ~/.bashrc

# Create custom conda environment
conda env create -f https://raw.githubusercontent.com/parkererickson/tg-sagemaker-test/main/environment-gpu.yml

# Activate our freshly created environment
source /home/ec2-user/anaconda3/bin/activate tigergraph-ml

# Expose environment as kernel
python -m ipykernel install --user --name tigergraph-ml --display-name TigerGraph-ML-PyG

# Deactivate environment
source /home/ec2-user/anaconda3/bin/deactivate

EOF
```
#### CPU Configuration
For the CPU  instance, you can directly use the ```start_notebook.sh``` script. By default, it uses the ```environment-cpu.yml``` file.

#### Add Configuration to Lifecycle Configuration (GUI Version)
Once you have copied the configuration script, we can create a new Lifecycle configuration using the SageMaker web UI.

### Create Notebook

#### Add Lifecycle Configuration to Notebook

#### Add Tutorial GitHub Repo

## Train a Model