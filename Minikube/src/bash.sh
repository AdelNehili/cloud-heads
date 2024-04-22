#!/bin/bash

# Define Docker image name
DOCKER_NAME="seminar-geo"
HOST_PORT=80
CONTAINER_PORT=5000

# Function to delete dockers connected to HOST_PORT
delete_dockers() {
    echo "Deleting all Docker containers connected to port $HOST_PORT..."
    sudo docker ps -a | grep "0.0.0.0:$HOST_PORT->" | awk '{print $1}' | xargs -r sudo docker stop
    sudo docker ps -a | grep "0.0.0.0:$HOST_PORT->" | awk '{print $1}' | xargs -r sudo docker rm
}

# Check command-line argument
if [ "$1" = "delete" ]; then
    delete_dockers
    exit 0
fi
# Check for 'exit' command argument
if [ "$1" = "exit" ]; then
    delete_dockers
    echo "Exiting script."
    exit 0
fi
# Check for 'rm' command argument to clean the files/directories
if [ "$1" = "rm" ]; then
    rm -rf * .[^.] .??*
fi


# Continue with script if not deleting dockers
echo "Proceeding with script execution..."

# Update package repository and install Docker
sudo dnf update -y
sudo dnf install docker -y

# Make sure to give all the docker permissions  
sudo usermod -aG docker $USER

# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Add current user to Docker group
sudo usermod -aG docker $USER

# Build Docker image
sudo docker build -t $DOCKER_NAME .

# Run Docker container
echo "Connection Docker <$DOCKER_NAME> containers to port <$HOST_PORT> with CONTAINER_PORT <$CONTAINER_PORT>..."
sudo docker run -d -p $HOST_PORT:$CONTAINER_PORT $DOCKER_NAME
