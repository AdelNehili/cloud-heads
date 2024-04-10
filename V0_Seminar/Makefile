# Docker's Infos
IMAGE_NAME=seminar-geo
HOST_PORT_LOCAL=8000
CONTAINER_PORT=5000

# EC2 Infos
PEM_FILENAME = labsuser
PUBLIC_IP_ADDRESS = 34.229.152.146

test:
	sudo cp $(PEM_FILENAME).pem ~/$(PEM_FILENAME).pem
	sudo chmod 400 ~/$(PEM_FILENAME).pem
	sudo scp -i ~/$(PEM_FILENAME).pem ./aws_files/src/* ec2-user@$(PUBLIC_IP_ADDRESS):~/
	sudo ssh -i ~/$(PEM_FILENAME).pem ec2-user@$(PUBLIC_IP_ADDRESS) "mkdir -p ~/templates"
	sudo scp -i ~/$(PEM_FILENAME).pem -r ./aws_files/ressources/templates/* ec2-user@$(PUBLIC_IP_ADDRESS):~/templates/
	sudo ssh -i ~/$(PEM_FILENAME).pem ec2-user@$(PUBLIC_IP_ADDRESS)


run_docker_local:
	
	docker run -p $(HOST_PORT_LOCAL):$(CONTAINER_PORT) $(IMAGE_NAME)
build_local:
	IMAGE_NAME=test_yaml
	docker build -t $IMAGE_NAME -f ./flask_project/src/Dockerfile ./flask_project/src
delete_docker_local:
	docker ps -a | grep "0.0.0.0:${HOST_PORT_LOCAL}->" | awk '{print $1}' | xargs -r docker stop	
	docker ps -a | grep "0.0.0.0:${HOST_PORT_LOCAL}->" | awk '{print $1}' | xargs -r docker rm
	docker ps -a | grep "0.0.0.0:${HOST_PORT_LOCAL}->"