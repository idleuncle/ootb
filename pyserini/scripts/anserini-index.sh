#!/usr/bin/env bash

DATASET_NAME=$1
ANSERINI_DATADIR=/anserini_data
python -m pyserini.index \
    -collection JsonCollection \
    -generator DefaultLuceneDocumentGenerator \
    -input ${ANSERINI_DATADIR}/${DATASET_NAME}/jsonl \
    -index ${ANSERINI_DATADIR}/${DATASET_NAME}/index \
    -threads 1 -storePositions -storeDocvectors -storeRaw
