#!/usr/bin/env bash

: ${OOTB_HOME:=$HOME/.ootb}
: ${MINIO_DATADIR:=$OOTB_HOME/minio/data}
: ${MINIO_LOGDIR:=$OOTB_HOME/minio/log}
: ${MINIO_PORT:=9000}
: ${OOTB_MINIO_NAME:=ootb-minio}

if [ ! -d ${OOTB_HOME} ]; then
    echo mkdir ${OOTB_HOME}
    mkdir -p ${OOTB_HOME} 
fi


if [ ! -d ${MINIO_DATADIR} ]; then
    echo mkdir ${MINIO_DATADIR}
    mkdir -p ${MINIO_DATADIR} 
fi

if [ ! -d ${MINIO_LOGDIR} ]; then
    echo mkdir ${MINIO_LOGDIR}
    mkdir -p ${MINIO_LOGDIR} 
fi

echo OOTB_MINIO_NAME: ${OOTB_MINIO_NAME}
echo OOTB_HOME: ${OOTB_HOME}
echo MINIO_DATADIR: ${MINIO_DATADIR}
echo MINIO_PORT: ${MINIO_PORT}

docker pull registry.cn-shanghai.aliyuncs.com/ootb/minio && \
    docker tag registry.cn-shanghai.aliyuncs.com/ootb/minio minio/minio


docker run --name ${OOTB_MINIO_NAME} -itd \
    -p ${MINIO_PORT}:9000 \
    -v ${MINIO_DATADIR}:/data \
    --restart always \
    minio/minio server /data

docker ps | grep ${OOTB_MINIO_NAME}
docker logs ${OOTB_MINIO_NAME}
