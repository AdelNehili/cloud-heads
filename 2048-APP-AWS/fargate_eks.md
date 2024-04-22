# Prequisite
1. download awscli, ekstctl, kubectl, helm 
2. create an IAM access ID/Key pair on your IAM profile (using root privilege is ok but not recommended)
3. configure you awscli by running the ```aws configure```

# Cluster creation 

ekstcl create cluster \ 
--name demo-cluster-1 \ => state the name
--region eu-west-3 \ => state the region
--fargate => fargate activation



# Configure the local kubectl to interact with EKS cluster
command-line tool to interact with the EKS cluster
=> absolutely needed to manage EKS with kubectl 

aws eks update-kubeconfig \
--name demo-cluster-1 \
--region eu-west-3

# Configuration of the EKS cluster to automatically run pods in the specified name space on AWS FArgate

eksctl create fargateprofile \
--cluster demo-cluster-1 \
--region eu-west-3 \
--name fp-app \
--namespace game-2048 
=> targets the specific kubernetes namespace where the Fargate profile should be applied,
=> allows to split cluster resources between multipe users


# Deploy the deployment (docker we want), the service and the Ingress

kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.5.4/docs/examples/2048/2048_full.yaml


kubectl get pods -n game-2048

kubectl get pods -n game-2048 -w

kubectl get svc -n game-2048

kubectl get ingress -n game-2048


# Association of an IAM OIDC provider for the EKS cluster
assignation of specific IAM roles to Kubernetes

eksctl utils associate-iam-oidc-provider \
--cluster demo-cluster-1 \
--approve


# Create a new policy with necessary permissions for the AWS Load Balancer to manage the Elastic Load Balancer

curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.5.4/docs/install/iam_policy.json

aws iam create-policy \
--policy-name AWSLoadBalancerControllerIAMPolicy \
--policy-document file://iam_policy.json


# Create an iamserviceaccount who will assume the Load Balance IAM role taking the required permissions

eksctl create iamserviceaccount \
--cluster=demo-cluster-1 \
--namespace=kube-system \
--name=aws-load-balancer-controller \
--role-name AmazonEKSLoadBalancerControllerRole \
--attach-policy-arn=arn:aws:iam::339712729595:policy/AWSLoadBalancerControllerIAMPolicy \
--approve


# Deploying the Load Balancer Controller into the EKS Cluster

helm repo add eks https://aws.github.io/eks-charts
helm repo update eks

helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system \
--set clusterName=demo-cluster-1 \
--set serviceAccount.create=false \
--set serviceAccount.name=aws-load-balancer-controller \
--set region=eu-west-3 \
--set vpcId=

# Wait a bit and check the following commands, you will see that the container is initializing

kubectl get deployment -n kube-system aws-load-balancer-controller

kubectl get deploy -n kube-system

kubectl get pods -n kube-system

# Run the following commands to have the public DNS to the game (you might have to wait a couple of minutes until the content is accessible, just refresh the web page as needed until having a good display)

kubectl get ingress -n game-2048

kubectl get ingress -n game-2048


# Delete the cluster
eksctl delete cluster --name demo-cluster-1 --region eu-west-3