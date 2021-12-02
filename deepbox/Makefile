APP_NAME=deepbox
IMAGE_NAME=ootb/${APP_NAME}

build_docker:
	docker build -t ${IMAGE_NAME} .


run_docker:
	docker run -it --rm \
		--gpus 0 \
		-p 18088:18088 \
		${IMAGE_NAME} \
		/bin/bash


start_docker:
	docker run -itd \
		--gpus 0 \
		-p 18088:18088 \
		--name ${APP_NAME} \
		${IMAGE_NAME} \


exec_docker:
	docker exec -it \
		${APP_NAME} \
		/bin/bash

stop_docker:
	docker rm -f ${APP_NAME}
