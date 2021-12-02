NAME=embedded
help:
	make [build_docker|run_docker|push_docker]

build_docker_base:
	docker build -f Dockerfile.base -t ootb/${NAME}:base .

push_docker_base:
	docker push ootb/${NAME}:base

run_docker_base:
	docker run -it --rm \
		--gpus 0 \
		ootb/${NAME}:base \
		/bin/bash

build_docker_dev:
	docker build -f Dockerfile.dev -t ootb/${NAME}:dev .

push_docker_dev:
	docker push ootb/${NAME}:dev

run_docker_dev:
	docker run -it --rm \
		--gpus 0 \
		ootb/${NAME}:dev \
		/bin/bash

run:
	PYTHONPATH=${PWD} python main.py
