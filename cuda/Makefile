help:
	make [build_docker|run_docker]

build_docker:
	docker build -t ootb/gridsim .

push_docker:
	docker push ootb/gridsim

run_docker:
	docker run -it --rm \
		--gpus 0 \
		ootb/gridsim \
		/bin/bash

build_docker_cuda102_py36:
	docker build -f Dockerfile.cuda10.2-devel-ubuntu18.04-py36 \
		-t ootb/cuda:10.2-devel-ubuntu18.04-py36 \
		.
build_docker_cuda102_py37:
	docker build -f Dockerfile.cuda10.2-devel-ubuntu18.04-py37 \
		-t ootb/cuda:10.2-devel-ubuntu18.04-py37 \
		.

build_docker_cuda102_py38:
	docker build -f Dockerfile.cuda10.2-devel-ubuntu18.04-py38 \
		-t ootb/cuda:10.2-devel-ubuntu18.04-py38 \
		.

build_docker_cuda111_py37:
	docker build -f Dockerfile.cuda11.1-devel-ubuntu18.04-py37 \
		-t ootb/cuda:11.1-devel-ubuntu18.04-py37 \

build_docker_cuda112_py38:
	docker build -f Dockerfile.cuda11.2-devel-ubuntu18.04-py38 \
		-t ootb/cuda:11.2-devel-ubuntu18.04-py38 \
		.

build_docker_cuda112_py39:
	docker build -f Dockerfile.cuda11.2-devel-ubuntu18.04-py39 \
		-t ootb/cuda:11.2-devel-ubuntu18.04-py39 \
		.

run:
	PYTHONPATH=${PWD} LD_LIBRARY_PATH=${PWD}/lib64 python main.py
