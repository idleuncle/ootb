FROM ootb/cuda:11.2-devel-ubuntu18.04-py38

COPY pip.conf /root/.pip/pip.conf
COPY requirements*.txt ./
RUN pip install -r requirements_base.txt
RUN pip install -r requirements_nlp.txt
RUN pip install -r requirements_cv.txt
RUN pip install -r requirements_rl.txt

COPY jupyter_server_config.json /root/.jupyter/
RUN pip install supervisor

WORKDIR /work
COPY supervisord.conf .
EXPOSE 18088

CMD ["/usr/local/bin/supervisord", "-c", "/work/supervisord.conf"]
