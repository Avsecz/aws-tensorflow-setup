# Setting up TensorFlow 0.9 with Python 3.5 on AWS GPU-instance

## Description

`setup-aws-tensorflow.bash` installs the following things on the ec2 `g2.2xlarge` instance running Ubuntu 14.04:

- Required linux packages
- CUDA 7.5
- cuDNN v4
- Anaconda with Python 3.5
- TensorFlow 0.9
- GPU usage tool `gpustat`

It is based on the blog post published [here](http://max-likelihood.com/2016/06/18/aws-tensorflow-setup/).

## Usage

1. Register and download the cuDNN v4 from [here](https://developer.nvidia.com/rdp/cudnn-download). File name should be `cudnn-7.0-linux-x64-v4.0-prod.tgz`.

2. Put it into your dropbox and copy the shared file link.

3. Run `setup_aws_tensorflow.bash` on the aws instance, providing the cuDNN link from your dropbox as argument:

```bash
setup_aws_tensorflow.bash https://www.dropbox.com/s/.../cudnn-7.0-linux-x64-v4.0-prod.tgz
```

