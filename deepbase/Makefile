IMAGE_NAME=deepbase
IMAGE_VERSION=10.2-cudnn7-devel-ubuntu18.04
help:
	@echo "Usage: make [build|run|daemon|exec]"

run:
	docker run --gpus all -it --rm --name ${IMAGE_NAME} \
		-e DEEPCODE_UID=$(DEEPCODE_UID) \
		-e DEEPCODE_GROUPS=$(DEEPCODE_GROUPS) \
		-v ${PWD}:/deepcode \
		${IMAGE_NAME} /bin/bash

daemon:
	docker run --gpus all -itd --name ${IMAGE_NAME} \
		-e DEEPCODE_UID=$(DEEPCODE_UID) \
		-e DEEPCODE_GROUPS=$(DEEPCODE_GROUPS) \
		-v ${PWD}:/deepcode \
		${IMAGE_NAME} /bin/bash

exec:
	docker exec -it ${IMAGE_NAME} /bin/bash

build:
	docker build -f Dockerfile.deepbase \
		-t ${IMAGE_NAME}:${IMAGE_VERSION} . && \
		docker tag ${IMAGE_NAME}:${IMAGE_VERSION} ootb/${IMAGE_NAME}:${IMAGE_VERSION} && \
		docker tag ${IMAGE_NAME}:${IMAGE_VERSION} registry.cn-shanghai.aliyuncs.com/ootb/${IMAGE_NAME}:${IMAGE_VERSION} && \
		docker tag ${IMAGE_NAME}:${IMAGE_VERSION} ${IMAGE_NAME}:latest && \
		docker tag ootb/${IMAGE_NAME}:${IMAGE_VERSION} ootb/${IMAGE_NAME}:latest && \
		docker tag registry.cn-shanghai.aliyuncs.com/ootb/${IMAGE_NAME}:${IMAGE_VERSION} registry.cn-shanghai.aliyuncs.com/ootb/${IMAGE_NAME}:latest 

