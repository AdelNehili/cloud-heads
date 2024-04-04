# Docker's Infos
IMAGE_NAME=seminar-geo
HOST_PORT=8000
CONTAINER_PORT=5000

# EC2 Infos
PEM_FILENAME = labsuser
PUBLIC_IP_ADDRESS = 44.223.62.184

test:
	sudo cp $(PEM_FILENAME).pem ~/$(PEM_FILENAME).pem
	sudo chmod 400 ~/$(PEM_FILENAME).pem
	scp -i ~/$(PEM_FILENAME).pem ./aws_files/src/* ec2-user@$(PUBLIC_IP_ADDRESS):~/
	scp -i ~/$(PEM_FILENAME).pem -r ./aws_files/ressources/templates ec2-user@$(PUBLIC_IP_ADDRESS):~/templates
	ssh -i ~/$(PEM_FILENAME).pem ec2-user@$(PUBLIC_IP_ADDRESS)



run_docker_local:
	docker run -p $(HOST_PORT):$(CONTAINER_PORT) $(IMAGE_NAME)
build_local:
	docker build -t $(IMAGE_NAME) -f ./aws_files/src/Dockerfile ./aws_files/src/
delete_docker_local:
	docker ps -a | grep "0.0.0.0:${HOST_PORT}->" | awk '{print $1}' | xargs -r docker stop	
	docker ps -a | grep "0.0.0.0:${HOST_PORT}->" | awk '{print $1}' | xargs -r docker rm
	docker ps -a | grep "0.0.0.0:${HOST_PORT}->"