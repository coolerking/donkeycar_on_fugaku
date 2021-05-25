# Donkeycar on Fugaku

Run [donkeycar v4.2](https://www.donkeycar.com) training app on [Fugaku](https://www.fujitsu.com/jp/about/businesspolicy/tech/fugaku/) compute node.

> tested at May 25th 2021.

## Setup

* Login to Fugaku login node with SSH client.

> For details, please show fugaku manual on the portal site.

* Set up spack release 0.16.

> In details, please show fugaku spack manual how to install.

```bash
cd ~/
git clone https://github.com/spack/spack.git ~/spack
cd ~/spack
git checkout releases/0.16
```

* Checkout repo.

```bash
cd ~/
mkdir jobs
cd jobs
git clone http://github.com/coolerking/donkeycar_on_fugaku.git
```

## Install Donkeycar v4.2

> Install virtualenv if not yet.
>
> ```bash
> pip install virtualenv --user
> ```

* Login to Fugaku login node with SSH client.
* add execute option

```bash
cd ~/jobs/donkeycar_on_fugaku
chmod +x *.sh
```

* Run 01_create_env.sh with pjsub.

```bash
pjsub 01_create_env.sh
```

* Then, run 02_spack_install.sh with pjsub.

```bash
pjsub 02_spack_install.sh
```

* Finally, run 03_install_donkeycar.sh with pjsub.

```bash
pjsub 03_install_donkeycar.sh
```

## Training

> Put tub data in ~/mycar/data with WinSCP.

* Login to Fugaku login node with SSH client.
* Create and run pjsub script like as:

```bash
#!/bin/bash
#PJM --rsc-list "node=1"
#PJM --rsc-list "rscunit=rscunit_ft01"
#PJM --rsc-list "rscgrp=small"
#PJM --rsc-list "elapse=10:00:00"
#PJM --mpi "proc=1"
#PJM -S

# spack/virtual env name
export ENV_NAME="donkeycar"
#export ENV_NAME="env"
# Machine Learning Framework
#export ML_LIB_NAME="PyTorch-1.7.0"
export ML_LIB_NAME="TensorFlow-2.2.0"


# for python3 with ML_LIB
export PATH=/lib64:/home/apps/oss/$ML_LIB_NAME/bin:$PATH
export LD_LIBRARY_PATH=/home/apps/oss/$ML_LIB_NAME/lib:$LD_LIBRARY_PATH
# for cmake
export PYTHON_DEFAULT_EXECUTABLE=/home/apps/oss/$ML_LIB_NAME/bin/python3
export PYTHON3_EXECUTABLE=$PYTHON_DEFAULT_EXECUTABLE

# virtual env
cd ~/local/aarch64/virtualenv
source $ENV_NAME/bin/activate
# spack env
cd ~/
source ~/spack/share/spack/setup-env.sh
spack env activate $ENV_NAME
spack env status

cd ~/mycar
date
donkey train --tub ./data/* --model ./models/mypilot.h5
date
```

## License

* [MIT License](./LICENSE)
