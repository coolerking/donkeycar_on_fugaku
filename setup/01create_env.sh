#!/bin/bash
#PJM --rsc-list "node=1"
#PJM --rsc-list "rscunit=rscunit_ft01"
#PJM --rsc-list "rscgrp=small"
#PJM --rsc-list "elapse=72:00:00"
#PJM --mpi "proc=1"
#PJM -S

export ENV_NAME="ratf_pytorch170"


echo "**** 01create_env.sh start ****"
date

echo "** 0101 set system environments **"
# for python3 with pytorch1.7.0
export PATH=/lib64:/home/apps/oss/PyTorch-1.7.0/bin:$PATH
export LD_LIBRARY_PATH=/home/apps/oss/PyTorch-1.7.0/lib:$LD_LIBRARY_PATH
# for cmake
export PYTHON_DEFAULT_EXECUTABLE=/home/apps/oss/PyTorch-1.7.0/bin/python3
export PYTHON3_EXECUTABLE=$PYTHON_DEFAULT_EXECUTABLE
echo "python3 path"
which python3
echo "python path"
which python


echo "** 0102 create virtualenv env **"
cd ~/local/aarch64/virtualenv
python3 -m virtualenv -p python3 $ENV_NAME --system-site-packages
source $ENV_NAME/bin/activate

echo "** 0103 create spack env **"
source ~/spack/share/spack/setup-env.sh
spack env list
spack env create $ENV_NAME
spack env list
spack env activate $ENV_NAME
echo "python3 path"
which python3
echo "python path"
which python

echo "**** 01create_env.sh end ****"
spack env status
spack env deactivate
date