#!/bin/bash

# Check kubectl Context and Configuration
# Check if the first argument is "rst" to reset the environment



if [ "$1" = "rst" ]; then
    #Minikube reset in case, we got errors
    minikube stop
    minikube delete
    minikube start

elif [ "$1" = "clear" ]; then
    #Clear all the .yaml files in the kubernetes
    kubectl delete deployment my-deployment
    kubectl delete service my-service

    kubectl delete -f aws-deploy.yaml
    kubectl delete -f aws-service.yaml

elif [ "$1" = "kube-context" ]; then
    #Knowing the kubernetes can be listen by multiple container manager(aws/minikube), we have to be sure to send to the correct one
    kubectl config get-contexts
    kubectl config current-context

elif [ "$1" = "tunnel" ]; then
    #Care, this bash command should be runned in another terminal
    minikube start
    minikube tunnel

elif [ "$1" = "load" ]; then
    #Allows to send the image to MINIKUBE
    IMAGE_NAME=test_yaml:latest
    docker build -t $IMAGE_NAME -f ./V1_flask_project/src/Dockerfile ./V1_flask_project/src
    echo "minikube image loading..."
    minikube image load $IMAGE_NAME

elif [ "$1" = "deploy" ]; then
    #Deploy the kubernete with all the yaml informations
    kubectl apply -f my-deploy.yaml
    kubectl apply -f my-service.yaml


elif [ "$1" = "display" ]; then
    #DIsplay the state of deployement/services
    echo "//__kubectl get deployments"
    kubectl get deployments
    echo""

    echo "//__kubectl get services"
    kubectl get services
    echo""

    echo "//__kubectl get pod"
    kubectl get pod
    echo""
fi


echo "Done."
