FROM ootb/deepbase:10.2-cudnn7-devel-ubuntu18.04


RUN apt-get update && apt-get install -y ca-certificates lsb-release cmake apt-utils
RUN apt-get install -y default-jdk maven

# RUN wget https://apache.jfrog.io/artifactory/arrow/$(lsb_release --id --short | tr 'A-Z' 'a-z')/apache-arrow-archive-keyring-latest-$(lsb_release --codename --short).deb
# RUN apt install -y -V ./apache-arrow-archive-keyring-latest-$(lsb_release --codename --short).deb
# RUN sed -i'' -e 's,https://apache.bintray.com/,https://apache.jfrog.io/artifactory/,g' /etc/apt/sources.list.d/apache-arrow.sources
# RUN apt-get update && apt-get install -y libarrow-dev libarrow-dataset-dev #libarrow-glib-dev  #libarrow-flight-dev

# RUN apt-get install -y libjemalloc-dev libboost-dev libboost-filesystem-dev libboost-system-dev libboost-regex-dev python3-dev
# RUN apt-get install -y autoconf flex bison
RUN pip install -U pyarrow==3.0.0
RUN pip install streamlit st-annotated-text 

RUN mkdir -p /root/.pip && echo "[global]\nindex-url=https://mirrors.aliyun.com/pypi/simple/\n[install]\ntrusted-host=mirrors.aliyun.com\n" >> /root/.pip/pip.conf
# RUN pip install pyserini

# EXPOSE 8051

RUN pip install dill



WORKDIR /app
RUN apt-get update && apt-get install -y build-essential
RUN apt-get install git && git config --global http.sslverify false &&  git clone https://hub.fastgit.org/castorini/anserini.git

# 设置maven源
COPY settings.xml /usr/share/maven/conf
#ENV JAVA_HOME /usr/lib/jvm/openjdk-11

RUN ls -lt /usr/lib/jvm/
RUN ls -lt /usr/lib/jvm/openjdk-11/
RUN ls -lt /usr/lib/jvm/java-11-openjdk-amd64/
RUN ls -lt /usr/lib/jvm/java-11-openjdk-amd64/bin/
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64
RUN cd anserini && PATH=/usr/lib/jvm/java-11-openjdk-amd64/bin:${PATH} mvn clean package appassembler:assemble

# RUN apt-get install build-essential
# 编译评测工具
RUN git clone https://hub.fastgit.org/castorini/anserini-tools.git tools
RUN cd tools/eval && tar xvfz trec_eval.9.0.4.tar.gz && cd trec_eval.9.0.4 && make && cd ../../..
RUN cd tools/eval/ndeval && make && cd ../../..

# pyserini
RUN git clone https://hub.fastgit.org/castorini/pyserini.git
RUN ln -s /app/anserini/target/anserini-0.11.1-SNAPSHOT-fatjar.jar /app/pyserini/pyserini/resources/jars/anserini-0.11.1-SNAPSHOT-fatjar.jar

# https://docs.streamlit.io/en/latest/troubleshooting/not-loading.html
# RUN mkdir -p /root/.streamlit && echo "[server]\nenableCORS = false\nenableXsrfProtection = false\n" >> /root/.streamlit/config.toml

RUN pip install pyjnius

# ------------------------------------------------------------
ENV PYTHONPATH /app/pyserini

ADD scripts ./scripts

# RUN echo "#!/bin/bash\nPYTHONPATH=${PWD}/pyserini streamlit run src/webapp.py" > /app/start_webapp.sh
