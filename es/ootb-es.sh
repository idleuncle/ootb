#!/usr/bin/env bash

: ${OOTB_HOME:=$HOME/.ootb}

: ${ES_DATADIR:=$OOTB_HOME/es/data}
: ${ES_LOGDIR:=$OOTB_HOME/es/log}
: ${ES_PORT1:=9200}
: ${ES_PORT2:=9300}
: ${OOTB_ES_NAME:=ootb-es}

if [ ! -d ${OOTB_HOME} ]; then
    echo mkdir ${OOTB_HOME}
    mkdir -p ${OOTB_HOME} 
fi


if [ ! -d ${ES_DATADIR} ]; then
    echo mkdir ${ES_DATADIR}
    mkdir -p ${ES_DATADIR} 
fi

if [ ! -d ${ES_LOGDIR} ]; then
    echo mkdir ${ES_LOGDIR}
    mkdir -p ${ES_LOGDIR} 
fi

echo OOTB_ES_NAME: ${OOTB_ES_NAME}
echo OOTB_HOME: ${OOTB_HOME}
echo ES_DATADIR: ${ES_DATADIR}
echo ES_LOGDIR: ${ES_LOGDIR}
echo ES_PORT1: ${ES_PORT1}
echo ES_PORT2: ${ES_PORT2}

docker pull registry.cn-shanghai.aliyuncs.com/ootb/elasticsearch:7.6.2 && \
    docker tag registry.cn-shanghai.aliyuncs.com/ootb/elasticsearch:7.6.2 elasticsearch:7.6.2

docker run --name ${OOTB_ES_NAME} -itd \
    -p ${ES_PORT1}:9200 \
    -p ${ES_PORT2}:9300 \
    -v ${ES_DATADIR}:/usr/share/elasticsearch/data \
    -v ${ES_LOGDIR}:/usr/share/elasticsearch/logs \
    -e "discovery.type=single-node" \
    elasticsearch:7.6.2

docker ps | grep ${OOTB_ES_NAME}
