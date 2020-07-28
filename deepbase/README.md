
## Install nvidia-docker

https://github.com/NVIDIA/nvidia-docker
Make sure your have installed the NVIDIA Driver and Docker 19.03 for your linux distrubtion. 
Note that you do not need to install the CUDA toolkit on the host, but the driver needs to be installed.

**Ubuntu**
```
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
sudo systemctl restart docker
```
**CentOS**
```
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.repo | sudo tee /etc/yum.repos.d/nvidia-docker.repo

sudo yum install -y nvidia-container-toolkit
sudo systemctl restart docker
```

## Run
docker run --gpus all deepbase:10.1-cudnn7-runtime-ubuntu18.04 nvidia-smi

docker run --gpus 'device=0,1' deepbase:10.1-cudnn7-runtime-ubuntu18.04 nvidia-smi


## Build

```
python generate.py --cuda-ver 10.2 --cudnn-ver 7 Dockerfile.deepbase \
    pytorch tensorflow keras \
    transformers \
    tqdm loguru onnxruntime \
    ipython jupyter jupyterlab jupytext \
    python==3.7

sed -i -e "s/^\n//g" Dockerfile.deepbase

# PIP_FIRST_INSTALL="python -m pip --no-cache-dir install --upgrade" && \
# PIP_INSTALL="pip install -i https://mirrors.aliyun.com/pypi/simple --no-cache-dir --upgrade" && \
# sed -i -e 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list && \
#    $PIP_FIRST_INSTALL \
#        setuptools \
#        && \

docker build -f Dockerfile.deepbase -t deepbase:1.0 .
```
