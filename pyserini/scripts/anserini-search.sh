#!/usr/bin/env bash
# tools/topics-and-qrels/topics.msmarco-passage.dev-subset.txt
DATASET_NAME=$1
ANSERINI_DATADIR=/anserini_data
RUNS_DIR=/anserini_runs
python -m pyserini.search \
    --topics msmarco-passage-dev-subset \
    --index $ANSERINI_DATADIR/${DATASET_NAME}/index \
    --output $ANSERINI_runs/${DATASET_NAME}.bm25.txt \
    --bm25 --msmarco \
    --hits 1000 --k1 0.82 --b 0.68
