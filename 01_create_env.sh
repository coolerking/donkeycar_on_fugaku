#!/bin/bash
#PJM --rsc-list "node=1"
#PJM --rsc-list "rscunit=rscunit_ft01"
#PJM --rsc-list "rscgrp=small"
#PJM --rsc-list "elapse=10:00:00"
#PJM --mpi "proc=1"
#PJM -S

# Create virtualenv /spack env
# set env name to ENV_NAME
# set Machine Learning Framework to ML_LIB_NAME
#
# Run as:
#  chmod +x 01_create_env.sh
#  pjsub 01_create_env.sh



echo "**** 01_create_env.sh start ****"
date
# spack/virtual env name
export ENV_NAME="donkeycar"
#export ENV_NAME="env"
# Machine Learning Framework
export ML_LIB_NAME="PyTorch-1.7.0"
#export ML_LIB_NAME="TensorFlow-2.2.0"

echo "** 0100 environments **"
echo "ml framework: $ML_LIB_NAME"
echo "env name:     $ENV_NAME"


echo "** 0101 set system environments **"
# for python3 with $ML_LIB_NAME
export PATH=/home/apps/oss/$ML_LIB_NAME/bin:$PATH
export LD_LIBRARY_PATH=/lib64:/home/apps/oss/$ML_LIB_NAME/lib:$LD_LIBRARY_PATH
# for cmake
export PYTHON_DEFAULT_EXECUTABLE=/home/apps/oss/$ML_LIB_NAME/bin/python3
export PYTHON3_EXECUTABLE=$PYTHON_DEFAULT_EXECUTABLE


echo "** 0102 create virtualenv env **"
cd ~/local/aarch64/virtualenv
python3 -m virtualenv -p python3 $ENV_NAME --system-site-packages
source $ENV_NAME/bin/activate

echo "** 0103 create spack env **"
source ~/spack/share/spack/setup-env.sh
spack env list
spack env create $ENV_NAME
spack env activate $ENV_NAME


echo "**** 01create_env.sh end ****"
spack env list
spack env status
spack env deactivate
date