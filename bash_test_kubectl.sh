#!/bin/bash

# Check if the first argument is "rst" to reset the environment
if [ "$1" = "rst" ]; then
    kubectl delete deployment test-yaml-deployment
    kubectl delete service test-yaml-service
    minikube stop
    minikube delete
    minikube start

fi

if [ "$1" = "clear" ]; then
    kubectl delete deployment test-yaml-deployment
    kubectl delete service test-yaml-service

    kubectl delete deployment nginx-deployment
    kubectl delete service nginx-service
fi

if [ "$1" = "load" ]; then
    IMAGE_NAME=test_yaml:latest
    docker build -t $IMAGE_NAME -f ./flask_project/src/Dockerfile ./flask_project/src
    minikube image load $IMAGE_NAME
fi

if [ "$1" = "deploy" ]; then
    kubectl apply -f nginx-deployment.yaml
    kubectl apply -f nginx-service.yaml
fi



echo "Done."
# Start Minikube tunnel in the background :
# Creates a route between your machine and the Minikube cluster, allowing services of type LoadBalancer to be accessed as if they had an external IP
#minikube start
#minikube tunnel &
