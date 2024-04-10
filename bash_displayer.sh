
#!/bin/bash

# Display deployment and service details

echo "//__kubectl get deployments"
kubectl get deployments
echo""

echo "//__kubectl get services"
kubectl get services
echo""

echo "//__kubectl get pod"
kubectl get pod
echo""

