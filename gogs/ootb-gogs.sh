#!/usr/bin/env bash

: ${OOTB_HOME:=$HOME/.ootb}
: ${GOGS_DATADIR:=$OOTB_HOME/gogs/data}
: ${GOGS_LOGDIR:=$OOTB_HOME/gogs/log}
: ${GOGS_PORT:=3000}
: ${OOTB_GOGS_NAME:=ootb-gogs}

if [ ! -d ${OOTB_HOME} ]; then
    echo mkdir ${OOTB_HOME}
    mkdir -p ${OOTB_HOME} 
fi


if [ ! -d ${GOGS_DATADIR} ]; then
    echo mkdir ${GOGS_DATADIR}
    mkdir -p ${GOGS_DATADIR} 
fi

if [ ! -d ${GOGS_LOGDIR} ]; then
    echo mkdir ${GOGS_LOGDIR}
    mkdir -p ${GOGS_LOGDIR} 
fi

echo OOTB_GOGS_NAME: ${OOTB_GOGS_NAME}
echo OOTB_HOME: ${OOTB_HOME}
echo GOGS_DATADIR: ${GOGS_DATADIR}
echo GOGS_PORT: ${GOGS_PORT}

docker pull registry.cn-shanghai.aliyuncs.com/ootb/gogs && \
    docker tag registry.cn-shanghai.aliyuncs.com/ootb/gogs gogs/gogs


docker run --name ootb-gogs -itd \
    -p ${GOGS_PORT}:3000 \
    -v ${GOGS_DATADIR}:/data \
    -v ${GOGS_LOGDIR}:/app/gogs/log \
    --restart always \
    gogs/gogs

docker ps | grep ootb-gogs
