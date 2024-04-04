#!/bin/bash

# Define Docker image name
DOCKER_NAME="seminar-geo"
HOST_PORT=8000
CONTAINER_PORT=9000



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
sudo docker run -d -p $HOST_PORT:$CONTAINER_PORT $DOCKER_NAME