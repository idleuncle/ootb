# 面向文本文件数据集，用自然语言检索数据集的段落。

> ootb/pyserini
> $HOME/sandbox/ootb/pyserini
> @gpu.huawei

> Anserini对划分好段落的文档（${ANSERINI_DATADIR}/*dataset_name*/jsonl/）构建索引（结果是一个索引目录${ANSERINI_DATADIR}/*dataset_name*/index/），

```makefile
# ------------------------------------------------------------
# 启动pyserini服务后台进程
#
# 设置ANSERINI_DATADIR环境变量指向数据根目录
# export ANSERINI_DATADIR=/opt/local/data/anserini_data
#
# ${ANSERINI_DATADIR}目录下每个数据集建一个单独的目录，
# 比如：${ANSERINI_DATADIR}/*dataset_name*
# ${ANSERINI_DATADIR}/dataset_name/jsonl目录存放按文档、段落两级组织的原始文档数据，
# 每份文档一个jsonl文件，文档中每个段落在jsonl文件中占一行，格式为：
# {“id”: “passage_id”, “contents”: “passage_text”, “data”=“passage_metadata”}
daemon:
	@echo ANSERINI_DATADIR: ${ANSERINI_DATADIR}
	docker run -itd \
      --name pyserini \
      -v ${ANSERINI_DATADIR}:/anserini_data \
      ootb/pyserini 

# ------------------------------------------------------------
# 停止pyserini服务
stop:
	docker rm -f pyserini

# ------------------------------------------------------------
# 进入pyserini的bash环境
exec:
	docker exec -it pyserini /bin/bash

# ------------------------------------------------------------
# 构建数据集的anserini索引
# 原生段落文本数据集在${ANSERINI_DATADIR}/dataset_name/jsonl/目录下
# 索引自动构建在${ANSERINI_DATADIR}/dataset_name/index目录下
# 输入参数：
# dataset_name: 数据集名称，${ANSERINI_DATADIR}的下一级目录名。
index:
	docker exec -it pyserini \
		./scripts/anserini-index.sh device_standards

# ------------------------------------------------------------
# 检索段落
# 输入参数：
# dataset_name: 数据集名称，${ANSERINI_DATADIR}的下一级目录名。
# question: 检索问句
# max_answers：返回匹配段落的最大数目。
search:
	 docker exec -it pyserini \
		 python scripts/search_passages.py \
		 --dataset_name device_standards \
		 --max_answers 100 \
		 --question "变压器温升"
```

### 原始文档数据组织

原始文档数据按文档、段落两级组织存放在一个目录下，推荐为${ANSERINI_DATADIR}/*dataset_name*/jsonl/，每份文档一个jsonl文件，文档中每个段落在jsonl文件中占一行，格式为：{“id”: “passage_id”, “contents”: “passage_text”, “data”=“passage_metadata”}

### 构建Anserini索引

collections/*dataset_name*/index/

```bash
scripts/anserini-index.sh dataset_name
```

### Anserini检索

```python
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
```
