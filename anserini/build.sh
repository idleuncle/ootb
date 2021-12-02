VERSION=1.0
CONTAINER_NAME=anserini
IMAGE_NAME=opspipe/aip:$CONTAINER_NAME$VERSION

echo "删除原来的容器$CONTAINER_NAME"
docker rm -f $CONTAINER_NAME

echo "删除原来的镜$IMAGE_NAME"
docker rmi -f $IMAGE_NAME

echo "构建docker镜像$IMAGE_NAME"
docker build -t $IMAGE_NAME .

echo "运行docker容器"
#docker run -d --name $CONTAINER_NAME -u es -p 9200:9200 -p 9300:9300 $IMAGE_NAME
docker run -d --name $CONTAINER_NAME -p 8888:8888 -p 9200:9200 $IMAGE_NAME sh run.sh
echo "$CONTAINER_NAME容器创建完成"

