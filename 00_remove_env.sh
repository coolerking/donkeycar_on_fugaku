#!/bin/bash
#PJM --rsc-list "node=1"
#PJM --rsc-list "rscunit=rscunit_ft01"
#PJM --rsc-list "rscgrp=small"
#PJM --rsc-list "elapse=10:00:00"
#PJM --mpi "proc=1"
#PJM -S

# Remove virtualenv /spack env
# set env name to ENV_NAME
#
# Run as:
#  chmod +x 00_remove_env.sh
#  pjsub 00_remove_env.sh




echo "**** 00_remove_env.sh start ****"
date
# spack/virtual env name
#export ENV_NAME="env"
export ENV_NAME="donkeycar"

echo "** 0000 environments **"
echo "env name:     $ENV_NAME"

echo "** 0001 clean spack env **"
source ~/spack/share/spack/setup-env.sh
spack env status
spack env remove -y $ENV_NAME


echo "** 0002 clean virtualenv env **"
cd ~/local/aarch64/virtualenv
rm -rf $ENV_NAME


echo "** 0003 remove tmp dirs/files **"
cd ~/
rm -rf ./tmp[a-zA-Z0-9]*
rm -rf ./tmp_*


echo "**** 00_remove_env.sh end ****"
date