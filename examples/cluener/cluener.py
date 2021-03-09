#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json
import os
import re
from collections import defaultdict

import numpy as np
import pandas as pd
from loguru import logger
from tqdm import tqdm

#  地址（address）
#  书名（book）
#  公司（company）
#  游戏（game）
#  政府（goverment）
#  电影（movie）
#  姓名（name）
#  组织机构（organization）
#  职位（position）
#  景点（scene）

ner_labels = [
    'address', 'book', 'company', 'game', 'government', 'movie', 'name',
    'organization', 'position', 'scene'
]
ner_connections = []


def clean_text(text):
    if text:
        text = text.strip()
    return text


def cluener_data_generator(train_file, desc=""):
    for i, line in enumerate(tqdm(open(train_file).readlines(), desc=desc)):
        guid = f"{i}"
        json_data = json.loads(line.strip())
        text = clean_text(json_data['text'])

        tags = []
        classes = json_data['label'].keys()
        for c in classes:
            c_labels = json_data['label'][c]
            for label, span in c_labels.items():
                x0, x1 = span[0]
                s = x0
                m = text[x0:x1 + 1]
                tags.append({'category': c, 'start': s, 'mention': m})
        yield guid, text, None, tags


def train_data_generator(train_file):
    if train_file is None:
        train_file = 'data/train.json'

    for guid, text, _, tags in cluener_data_generator(train_file,
                                                      desc="Train data"):
        yield guid, text, None, tags


def eval_data_generator(eval_file):
    if eval_file is None:
        eval_file = 'data/dev.json'

    for guid, text, _, tags in cluener_data_generator(eval_file,
                                                      desc="Eval data"):
        yield guid, text, None, tags


def test_data_generator(test_file):
    if test_file is None:
        test_file = 'data/test.json'

    for i, line in enumerate(
            tqdm(open(test_file).readlines(), desc="Test data: ")):
        guid = f"{i}"
        json_data = json.loads(line.strip())
        text = clean_text(json_data['text'])

        yield guid, text, None, None


def generate_submission(args):
    reviews_file = args.reviews_file
    reviews = json.load(open(reviews_file, 'r'))

    submission_file = f"./submissions/{args.dataset_name}_predict.json"
    test_results = []
    for guid, json_data in tqdm(reviews.items()):
        text = json_data['text']

        classes = {}
        for json_entity in json_data['tags']:
            c = json_entity['category']
            s = json_entity['start']
            m = json_entity['mention']
            if c not in classes:
                classes[c] = {}
            if m not in classes[c]:
                classes[c][m] = []
            classes[c][m].append([s, s + len(m) - 1])
        test_results.append({'id': guid, 'text': text, 'label': classes})

    with open(submission_file, 'w') as wt:
        for line in test_results:
            wt.write(f"{json.dumps(line, ensure_ascii=False)}\n")

    logger.info(f"Saved {len(reviews)} lines in {submission_file}")
