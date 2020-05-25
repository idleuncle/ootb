#!/usr/bin/env bash
SCRIPT_PATH=$(cd $(dirname ${BASH_SOURCE[0]}); pwd)
CURRENT_DIR=$PWD

BACKUP_FILE=$1
if [ "${BACKUP_FILE}_notfound" == "_notfound" ];
then
    echo "Usage: ootb-restore.sh <OOTB backup file> <restore dir>"
    exit 0
fi

RESTORE_DIR=$2
if [ "${RESTORE_DIR}_notfound" == "_notfound" ];
then
    echo "Usage: ootb-restore.sh <OOTB backup file> <restore dir>"
    exit 0
fi

if [ -d ${RESTORE_DIR} ];
then
    echo "${RESTORE_DIR} must be empty."
    exit 0
fi

mkdir -p ${RESTORE_DIR} && tar zxvf ${BACKUP_FILE} -C ${RESTORE_DIR}
echo "OOTB backup file ${BACKUP_FILE} restored to ${RESTORE_DIR}"
