#!/bin/bash
#PJM --rsc-list "node=1"
#PJM --rsc-list "rscunit=rscunit_ft01"
#PJM --rsc-list "rscgrp=small"
#PJM --rsc-list "elapse=72:00:00"
#PJM --mpi "proc=1"
#PJM -S

echo "** 00 setup environment test_mesa **"
date
source ~/spack/share/spack/setup-env.sh
spack env create test_mesa
spack env activate test_mesa
spack env status
export PATH=/lib64:/home/apps/oss/PyTorch-1.7.0/bin:$PATH
export LD_LIBRARY_PATH=/home/apps/oss/PyTorch-1.7.0/lib:$LD_LIBRARY_PATH
cd ~/local/aarch64/virtualenv/
python3 -m virtualenv -p python3 test_mesa --system-site-packages
source ~/local/aarch64/virtualenv/test_mesa/bin/activate
date

echo "** 01 mesa start **"
spack install mesa
date


echo "**** 99 eval gl.h****"
cd ~/spack/var/spack/environments/test_mesa
find . -name gl.h -print
date
