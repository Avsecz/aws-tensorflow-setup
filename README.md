# Setting up TensorFlow 0.9 with Python 3.5 on AWS GPU-instance

## Description

`setup-aws-tensorflow.bash` installs the following things on the ec2 `g2.2xlarge` instance running Ubuntu 14.04:

- Required linux packages
- CUDA 7.5
- cuDNN v4
- Anaconda with Python 3.5
- TensorFlow 0.9
- GPU usage tool `gpustat`

It is based on the blog post: <http://max-likelihood.com/2016/06/18/aws-tensorflow-setup/>.

## Usage

Just run `setup_aws_tensorflow.bash` on the aws instance:

```bash
./setup_aws_tensorflow.bash
```

