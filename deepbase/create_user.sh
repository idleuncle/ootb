#!/usr/bin/env bash

groupadd -g ${DEEPCODE_GROUPS} deepcode && \
        useradd -u ${DEEPCODE_UID} -g ${DEEPCODE_GROUPS} -ms /bin/bash deepcode
chown -R deepcode:deepcode /deepcode
su deepcode
