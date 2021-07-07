#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os, json
from tqdm import tqdm
from loguru import logger

from pyserini.search import SimpleSearcher


def get_args():
    from argparse import ArgumentParser
    parser = ArgumentParser()
    parser.add_argument("--dataset_name", type=str)
    parser.add_argument("--question", type=str)
    parser.add_argument("--max_answers", default=100, type=int)

    args = parser.parse_args()

    return args


args = get_args()
dataset_name = args.dataset_name
question = args.question
max_answers = args.max_answers

anserini_datadir = os.environ.get('ANSERINI_DATADIR', "/anserini_data")
anserini_index_dir = f"{anserini_datadir}/{dataset_name}/index"

searcher = SimpleSearcher(anserini_index_dir)
hits = searcher.search(question, max_answers)
for i in range(len(hits)):
    docid = hits[i].docid
    score = hits[i].score
    doc = searcher.doc(docid)
    json_doc = json.loads(doc.raw())
    json_data = json_doc.get('data', None)
    logger.info(f"{i}: {score:.4f} | {docid} | {json_data}")
