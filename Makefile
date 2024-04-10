IMAGE_NAME=test_yaml:latest
docker build -t $IMAGE_NAME -f ./flask_project/src/Dockerfile ./flask_project/src
docker run -p 5552:5000 -d test_yaml

sudo lsof -ti :5552 | xargs -r sudo kill -9
CONTAINER_ID=$(sudo docker ps -qf "ancestor=test_yaml" -f "expose=5552") && [ -n "$CONTAINER_ID" ] && docker stop "$CONTAINER_ID" && docker rm "$CONTAINER_ID"

minikube image load $IMAGE_NAME

minikube_display:
	minikube ssh
	docker images