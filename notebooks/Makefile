usage:
	@echo "[build|run]"

build:
	docker build -f Dockerfile.notebooks \
        -t ootb/notebooks:1.0 .

run:
	docker run -itd --rm --name notebooks \
		--gpus device=0 \
		--dns 208.67.222.222 --dns 218.85.157.99 \
		-p 8888:8888 \
		-v ${HOME}/sandbox:/notebooks \
		-v /opt/share/pretrained/pytorch/bert-base-chinese:/opt/share/pretrained/pytorch/bert-base-chinese \
		-v /opt/share/pretrained/pytorch/roberta-wwm-large-ext-chinese:/opt/share/pretrained/pytorch/roberta-wwm-large-ext-chinese \
		ootb/notebooks:1.0

run_slzy:
	docker run -itd --rm --name nb_slzy \
		--gpus device=0 \
		--dns 208.67.222.222 --dns 218.85.157.99 \
		-p 2020:8888 \
		-v ${HOME}/sandbox/slzy:/notebooks \
		ootb/notebooks:1.0
