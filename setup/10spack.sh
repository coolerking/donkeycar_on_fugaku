#!/bin/bash
#PJM --rsc-list "node=1"
#PJM --rsc-list "rscunit=rscunit_ft01"
#PJM --rsc-list "rscgrp=small"
#PJM --rsc-list "elapse=72:00:00"
#PJM --mpi "proc=1"
#PJM -S

export ENV_NAME="ratf_pytorch170"


echo "**** 10spack.sh start ****"
date

echo "** 1001 set system environments **"
# for python3 with pytorch1.7.0
export PATH=/lib64:/home/apps/oss/PyTorch-1.7.0/bin:$PATH
export LD_LIBRARY_PATH=/home/apps/oss/PyTorch-1.7.0/lib:$LD_LIBRARY_PATH
# for cmake
export PYTHON_DEFAULT_EXECUTABLE=/home/apps/oss/PyTorch-1.7.0/bin/python3
export PYTHON3_EXECUTABLE=$PYTHON_DEFAULT_EXECUTABLE


echo "** 1002 set virtualenv env **"
cd ~/local/aarch64/virtualenv
source $ENV_NAME/bin/activate


echo "** 1003 set spack env **"
cd ~/
source ~/spack/share/spack/setup-env.sh
spack env activate $ENV_NAME
spack env status
spack find


echo "** 1004 spack add/install **"
date
spack add mesa ldlibs="-ltinfo"
spack add hdf5 ldlibs="-ltinfo"
spack add openblas ldlibs="-ltinfo"
spack add libtiff ldlibs="-ltinfo"
spack add openjpeg ldlibs="-ltinfo"
spack add atlas ldlibs="-ltinfo"
date
spack install
date
spack find


echo "** 1005 check **"
cd ~/spack/var/spack/environments/$ENV_NAME/.spack-env/view/lib
ls -la
cd ~/spack/var/spack/environments/$ENV_NAME/.spack-env/view/include
ls -la
pwd


echo "**** 10spack.sh end ****"
cd ~/
spack env deactivate
date