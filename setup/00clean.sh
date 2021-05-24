#!/bin/bash
#PJM --rsc-list "node=1"
#PJM --rsc-list "rscunit=rscunit_ft01"
#PJM --rsc-list "rscgrp=small"
#PJM --rsc-list "elapse=72:00:00"
#PJM --mpi "proc=1"
#PJM -S

export ENV_NAME="ratf_pytorch170"

echo "**** 00clean.sh start ****"
date


echo "** 0001 clean spack env **"
source ~/spack/share/spack/setup-env.sh
spack env status
spack env remove -y $ENV_NAME


echo "** 0002 clean virtualenv env **"
cd ~/local/aarch64/virtualenv
rm -rf $ENV_NAME


echo "** 0003 remove tmp dirs **"
cd ~/
rm -rf ./tmp[a-zA-Z0-9]*
rm -rf ./tmp_*


echo "**** 00clean.sh end ****"
date