DOCKER_IMAGE=brat:1.0
build:
	docker build -f Dockerfile.brat -t  ${DOCKER_IMAGE} .

run:
	docker run -it --rm -p 8001:8001 ${DOCKER_IMAGE}


daemon:
	docker run -itd -p 8001:8001 ${DOCKER_IMAGE}
