#!/usr/bin/env bash
SCRIPT_PATH=$(cd $(dirname ${BASH_SOURCE[0]}); pwd)
CURRENT_DIR=$PWD

if [ "${OOTB_HOME}_notfound" == "_notfound" ];
then
    echo "OOTB_HOME is null."
else
    BACKUP_FILE=${CURRENT_DIR}/ootb_data_$(date '+%Y%m%d%H%M%S').tar.gz
    cd ${OOTB_HOME} && tar zcvf ${BACKUP_FILE} *
    echo "OOTB ${OOTB_HOME} data backup file: ${BACKUP_FILE}"
fi
