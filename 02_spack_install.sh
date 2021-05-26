#!/bin/bash
#PJM --rsc-list "node=1"
#PJM --rsc-list "rscunit=rscunit_ft01"
#PJM --rsc-list "rscgrp=small"
#PJM --rsc-list "elapse=10:00:00"
#PJM --mpi "proc=1"
#PJM -S

# Install packages with spack
# You need to install spack on ~/spack
# set env name to ENV_NAME
# set Machine Learning Framework to ML_LIB_NAME
#
# Run as:
#  chmod +x 02_spack_install.sh
#  pjsub 02_spack_install.sh



echo "**** 02_spack_install.sh start ****"
date
# spack/virtual env name
export ENV_NAME="donkeycar"
#export ENV_NAME="env"
# Machine Learning Framework
export ML_LIB_NAME="PyTorch-1.7.0"
#export ML_LIB_NAME="TensorFlow-2.2.0"

echo "** 0200 environments **"
echo "ml framework: $ML_LIB_NAME"
echo "env name:     $ENV_NAME"


echo "** 0201 set system environments **"
# for python3 with $ML_LIB_NAME
export PATH=/home/apps/oss/$ML_LIB_NAME/bin:$PATH
export LD_LIBRARY_PATH=/lib64:/home/apps/oss/$ML_LIB_NAME/lib:$LD_LIBRARY_PATH
# for cmake
export PYTHON_DEFAULT_EXECUTABLE=/home/apps/oss/$ML_LIB_NAME/bin/python3
export PYTHON3_EXECUTABLE=$PYTHON_DEFAULT_EXECUTABLE



echo "** 0202 set virtualenv/spack env **"
cd ~/local/aarch64/virtualenv
source $ENV_NAME/bin/activate
cd ~/
source ~/spack/share/spack/setup-env.sh
spack env activate $ENV_NAME
spack env status
spack find


echo "** 0203 spack add packages **"
date
spack add mesa ldlibs="-ltinfo"
spack add hdf5 ldlibs="-ltinfo"
spack add openblas ldlibs="-ltinfo"
spack add libtiff ldlibs="-ltinfo"
spack add openjpeg ldlibs="-ltinfo"
spack add atlas ldlibs="-ltinfo"
date


echo "** 0204 spack install packages **"
date
spack install
date
spack find


echo "** 0205 show installed lib/include **"
cd ~/spack/var/spack/environments/$ENV_NAME/.spack-env/view/lib
ls -la
cd ~/spack/var/spack/environments/$ENV_NAME/.spack-env/view/include
ls -la
pwd


cd ~/
spack env deactivate
date
echo "**** 02_spack_install.sh end ****"