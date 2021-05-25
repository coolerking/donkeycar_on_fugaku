#!/bin/bash
#PJM --rsc-list "node=1"
#PJM --rsc-list "rscunit=rscunit_ft01"
#PJM --rsc-list "rscgrp=small"
#PJM --rsc-list "elapse=72:00:00"
#PJM --mpi "proc=1"
#PJM -S

export ENV_NAME="ratf_pytorch170"
export PACKAGE_NAME="donkeycar"

echo "**** 21donkeycar.sh start ****"
date

echo "** 2101 set system environments **"
# for python3 with pytorch1.7.0
export PATH=/lib64:/home/apps/oss/PyTorch-1.7.0/bin:$PATH
export LD_LIBRARY_PATH=/home/apps/oss/PyTorch-1.7.0/lib:$LD_LIBRARY_PATH
# for cmake
export PYTHON_DEFAULT_EXECUTABLE=/home/apps/oss/PyTorch-1.7.0/bin/python3
export PYTHON3_EXECUTABLE=$PYTHON_DEFAULT_EXECUTABLE
# for pip install
export LDFLAGS="-L/lib64 -L/home/apps/oss/PyTorch-1.7.0/lib -L/vol0004/ra010001/a04335/spack/var/spack/environments/ratf_pytorch170/.spack-env/view/lib64 -L/vol0004/ra010001/a04335/spack/var/spack/environments/ratf_pytorch170/.spack-env/view/lib -L/opt/FJSVxtclanga/tcsds-1.2.31/lib64"
export CPPFLAGS="-I/include -I/home/apps/oss/PyTorch-1.7.0/include -I/vol0004/ra010001/a04335/spack/var/spack/environments/ratf_pytorch170/.spack-env/view/include -I/vol0004/ra010001/a04335/spack/var/spack/environments/ratf_pytorch170/.spack-env/view/include -I/opt/FJSVxtclanga/tcsds-1.2.31/include"
echo "python3 path"
which python3
echo "python path"
which python


echo "** 2102 set virtualenv env **"
cd ~/local/aarch64/virtualenv
source $ENV_NAME/bin/activate


echo "** 2103 set spack env **"
cd ~/
source ~/spack/share/spack/setup-env.sh
spack env activate $ENV_NAME
spack env status
pip list|grep $PACKAGE_NAME


echo "** 2104 pip install **"
date
cd ~/projects/ratf/donkeycar
git pull
pip install -e .[pc] --user
date


echo "** 2105 eval install **"
cd ~/
find . -name $PACKAGE_NAME -print
pip list | grep $PACKAGE_NAME


echo "**** 21donkeycar.sh end ****"
cd ~/
spack env deactivate
date