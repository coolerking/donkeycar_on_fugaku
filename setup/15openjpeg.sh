#!/bin/bash
#PJM --rsc-list "node=1"
#PJM --rsc-list "rscunit=rscunit_ft01"
#PJM --rsc-list "rscgrp=small"
#PJM --rsc-list "elapse=72:00:00"
#PJM --mpi "proc=1"
#PJM -S

export ENV_NAME="ratf_pytorch170"
export PACKAGE_NAME="openjpeg"

echo "**** 15openjpeg.sh start ****"
date

echo "** 1501 set system environments **"
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


echo "** 1502 set virtualenv env **"
cd ~/local/aarch64/virtualenv
source $ENV_NAME/bin/activate


echo "** 1503 set spack env **"
cd ~/
source ~/spack/share/spack/setup-env.sh
spack env activate $ENV_NAME
spack env status
spack find


echo "** 1504 spack install **"
date
spack install $PACKAGE_NAME ldlibs="-ltinfo"
date
spack find


echo "** 1505 eval install **"
spack find
find ~/spack/var/spack/environments/$ENV_NAME/.spack-env/view -name $PACKAGE_NAME -print


echo "**** 15openjpeg.sh end ****"
cd ~/
spack env deactivate
date