#!/bin/bash
#PJM --rsc-list "node=1"
#PJM --rsc-list "rscunit=rscunit_ft01"
#PJM --rsc-list "rscgrp=small"
#PJM --rsc-list "elapse=10:00:00"
#PJM --mpi "proc=1"
#PJM -S

# Install donkeycar v4.2 packages with pip
# It will install with ~/projects/donkeycar directory
# and create donkeycar app to ~/mycar
# set env name to ENV_NAME
# set Machine Learning Framework to ML_LIB_NAME
#
# Run as:
#  chmod +x 03_install_donkeycar.sh
#  pjsub 03_install_donkeycar.sh



echo "**** 03_install_donkeycar.sh start ****"
date
# spack/virtual env name
export ENV_NAME="donkeycar"
#export ENV_NAME="env"
# Machine Learning Framework
#export ML_LIB_NAME="PyTorch-1.7.0"
export ML_LIB_NAME="TensorFlow-2.2.0"

echo "** 0300 environments **"
echo "ml framework: $ML_LIB_NAME"
echo "env name:     $ENV_NAME"


echo "** 0301 set system environments **"
# for python3 with ML_LIB
export PATH=/home/apps/oss/$ML_LIB_NAME/bin:$PATH
export LD_LIBRARY_PATH=/lib64:/home/apps/oss/$ML_LIB_NAME/lib:$LD_LIBRARY_PATH
# for cmake
export PYTHON_DEFAULT_EXECUTABLE=/home/apps/oss/$ML_LIB_NAME/bin/python3
export PYTHON3_EXECUTABLE=$PYTHON_DEFAULT_EXECUTABLE
# for pip install with cmake
export LDFLAGS="-L/lib64 -L/home/apps/oss/$ML_LIB_NAME/lib -L~/spack/var/spack/environments/$ENV_NAME/.spack-env/view/lib64 -L~/spack/var/spack/environments/$ENV_NAME/.spack-env/view/lib -L/opt/FJSVxtclanga/tcsds-1.2.31/lib64"
export CPPFLAGS="-I/include -I/home/apps/oss/$ML_LIB_NAME/include -I~/spack/var/spack/environments/$ENV_NAME/.spack-env/view/include -I~/spack/var/spack/environments/$ENV_NAME/.spack-env/view/include -I/opt/FJSVxtclanga/tcsds-1.2.31/include"


echo "** 0302 set virtual/spack env **"
cd ~/local/aarch64/virtualenv
source $ENV_NAME/bin/activate
cd ~/
source ~/spack/share/spack/setup-env.sh
spack env activate $ENV_NAME
spack env status
pip list|grep donkeycar


echo "** 0303 get and pip install donkeycar **"
date
cd ~/projects/ratf
rm -rf donkeycar
echo "before git clone" 1>&2
git clone -b releases_4_2 https://github.com/autorope/donkeycar.git
echo "after git clone" 1>&2
cd ~/projects/ratf/donkeycar
#git checkout master
pwd
find . -name setup.py -print
pip install -e .[pc] --user
date
pip list | grep donkeycar

echo "** 0304 eval (create donkeycar app) **"
cd ~/
rm -rf ~/mycar
donkey createcar --path ~/mycar
ls -la ~/mycar

spack env deactivate
echo "**** 03_install_donkeycar.sh end ****"