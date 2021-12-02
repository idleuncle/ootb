# FROM maven:3.6.3-openjdk-11 as builder
FROM maven:3.6.3-openjdk-11
RUN apt-get update && apt-get install -y build-essential
RUN apt-get install git && git config --global http.sslverify false &&  git clone https://hub.fastgit.org/castorini/anserini.git

# 设置maven源
COPY settings.xml /usr/share/maven/conf
RUN cd anserini && mvn clean package appassembler:assemble

WORKDIR /app

# 拷贝编译后文件至工作目录
RUN cp -r /anserini .
RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.11.2-linux-x86_64.tar.gz
RUN mkdir elastirini && tar -zxvf elasticsearch*.tar.gz -C elastirini --strip-components=1
RUN rm -f elasticsearch-7.11.2-linux-x86_64.tar.gz

# 设置ES限制IP问题
RUN echo 'http.host: 0.0.0.0\n' >> elastirini/config/elasticsearch.yml

# 构建运行时镜像
# FROM zhys513/opspipe:py3-jdk11-ubuntu18.04
# FROM openjdk:11
ENV PYTHONIOENCODING=UTF-8
ENV LANG C.UTF-8
# RUN sysctl vm.max_map_count=524288
# WORKDIR /app

# 拷贝构建后的文件至运行时镜像
# COPY --from=builder /app /app

# RUN apt-get install build-essential
# 编译评测工具
RUN git clone https://hub.fastgit.org/castorini/anserini-tools.git tools
RUN cd tools/eval && tar xvfz trec_eval.9.0.4.tar.gz && cd trec_eval.9.0.4 && make && cd ../../..
RUN cd tools/eval/ndeval && make && cd ../../..

RUN groupadd es && useradd es -g es && su es && chown -R es:es elastirini

RUN apt-get install -y jupyter
RUN jupyter notebook --generate-config
# pwd=123
RUN echo "#c.NotebookApp.password='sha1:da00fa1e950a:0adb64c8359ef97932e5dde02d6167e140bac4e0' \nc.NotebookApp.notebook_dir='/app' \nc.NotebookApp.ip='*' \nc.NotebookApp.open_browser=False \nc.NotebookApp.port=8888 \nc.NotebookApp.allow_remote_access=True" >> /root/.jupyter/jupyter_notebook_config.py

RUN mkdir /root/.pip && echo "[global]\nindex-url=https://mirrors.aliyun.com/pypi/simple/\n[install]\ntrusted-host=mirrors.aliyun.com\n" >> /root/.pip/pip.conf
RUN ln -s /usr/bin/python3 /usr/local/bin/python
RUN python -m pip install pip
RUN ln -s /usr/bin/pip3 /usr/local/bin/pip
RUN pip install numpy pandas tqdm loguru

# pyserini
RUN git clone https://hub.fastgit.org/castorini/pyserini.git
RUN ln -s /app/anserini/target/anserini-0.11.1-SNAPSHOT-fatjar.jar /app/pyserini/pyserini/resources/jars/anserini-0.11.1-SNAPSHOT-fatjar.jar
RUN pip install scikit-learn pyjnius transformers

# RUN echo 'nohup jupyter notebook --allow-root > jupyter.log 2>&1 & \nsu es -s elastirini/bin/elasticsearch' >> run.sh
RUN echo 'nohup jupyter notebook --allow-root --no-browser > jupyter.log 2>&1 & \n' >> run.sh

CMD ["/bin/bash"]
