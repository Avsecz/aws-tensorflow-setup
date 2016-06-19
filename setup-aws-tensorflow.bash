#!/bin/bash

# Usage:
#
# 1. Put the cudnn file to your dropbox and share the link
# 2. Run this bash script on the instance, providing it the cudnn link on your dropbox:
# setup_aws_tensorflow.bash https://www.dropbox.com/s/.../cudnn-7.0-linux-x64-v4.0-prod.tgz

# stop on error
set -e

############################################
# input check

if ! [[ $# -eq 1 ]] ; then
    echo 'Usage: setup_aws_tensorflow.bash CUDNN_FILE_PATH
CUDNN_FILE_PATH is a downloadable path to cudnn-7.0-linux-x64-v4.0-prod.tgz
'
    exit 0
fi

# check the file input

CUDNN_FILE_PATH=$1
CUDNN_FILE=cudnn-7.0-linux-x64-v4.0-prod.tgz

if ! [[ "${CUDNN_FILE}" == "$(basename $CUDNN_FILE_PATH)" ]] ; then
    echo "Downloadable file should be cudnn-7.0-linux-x64-v4.0-prod.tgz, yours is $(basename $CUDNN_FILE_PATH)"
    exit 0
fi

############################################
# install the required packages
sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get -y install linux-headers-$(uname -r) linux-image-extra-`uname -r`

# install cuda
wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/cuda-repo-ubuntu1404_7.5-18_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1404_7.5-18_amd64.deb
rm cuda-repo-ubuntu1404_7.5-18_amd64.deb
sudo apt-get update
sudo apt-get install -y cuda

# get cudnn
wget $CUDNN_FILE_PATH
tar xvzf ${CUDNN_FILE}
rm ${CUDNN_FILE}
sudo cp cuda/include/cudnn.h /usr/local/cuda/include # move library files to /usr/local/cuda
sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
sudo chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*
rm -rf ~/cuda

# set the appropriate library path
echo 'export CUDA_HOME=/usr/local/cuda
export CUDA_ROOT=/usr/local/cuda
export PATH=$PATH:$CUDA_ROOT/bin:$HOME/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_ROOT/lib64
' >> ~/.bashrc

# install anaconda
wget http://repo.continuum.io/archive/Anaconda3-4.0.0-Linux-x86_64.sh
bash Anaconda3-4.0.0-Linux-x86_64.sh -b -p ~/bin/anaconda3
rm Anaconda3-4.0.0-Linux-x86_64.sh
echo 'export PATH="$HOME/bin/anaconda3/bin:$PATH"' >> ~/.bashrc
# reload bash
exec bash


# install tensorflow
export TF_BINARY_URL='https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow-0.9.0rc0-cp35-cp35m-linux_x86_64.whl'

pip install $TF_BINARY_URL

# install monitoring programs
sudo wget https://git.io/gpustat -O /usr/local/bin/gpustat
sudo chmod +x /usr/local/bin/gpustat
sudo nvidia-smi daemon
sudo apt-get -y install htop

############################################
# run the test
# byobu				# start byobu + press Ctrl + F2 
# htop				# run in window 1, press Shift + F2
# watch --color -n1.0 gpustat -cp	# run in window 2, press Shift + <left>
# wget https://raw.githubusercontent.com/tensorflow/tensorflow/master/tensorflow/models/image/mnist/convolutional.py
# python convolutional.py		# run in window 3
















