### ����docker���񣬲�����jupyter��ES
```
sh build.sh
```
ͨ�� http://docker������:8888 ����jupyter
���룺123
### ���ְ���
��ַ��https://github.com/castorini/anserini-notebooks/blob/master/anserini_robust04_demo.ipynb
```
wget https://git.uwaterloo.ca/jimmylin/anserini-indexes/raw/master/index-robust04-20191213.tar.gz
tar xvfz index-robust04-20191213.tar.gz -C indexes/
target/appassembler/bin/SearchCollection -topicreader Trec -index indexes/index-robust04-20191213  -topics src/main/resources/topics-and-qrels/topics.robust04.txt -output runs/run.robust04.bm25.txt -bm25
tools/eval/trec_eval.9.0.4/trec_eval -c src/main/resources/topics-and-qrels/qrels.robust04.txt runs/run.robust04.bm25.txt
```
