help:
	@echo Usage: make [build|daemon|stop|exec|index|search]

build:
	docker build -f Dockerfile -t ootb/pyserini .

# ------------------------------------------------------------
# 启动pyserini服务后台进程
#
# 设置ANSERINI_DATADIR环境变量指向数据根目录
# export ANSERINI_DATADIR=/opt/local/data/anserini_data
#
# ${ANSERINI_DATADIR}目录下每个数据集建一个单独的目录，
# 比如：${ANSERINI_DATADIR}/dataset_name
# ${ANSERINI_DATADIR}/dataset_name/jsonl目录存放按文档、段落两级组织的原始文档数据，
# 每份文档一个jsonl文件，文档中每个段落在jsonl文件中占一行，格式为：
# {“id”: “passage_id”, “contents”: “passage_text”, “data”=“passage_metadata”}
#
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
