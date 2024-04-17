# Prequisite
1. download awscli, ekstctl, kubectl, helm 
2. create a free tier aws account
3. create an IAM access ID/Key pair on your IAM profile (using root privilege is ok but not recommended)
4. configure you awscli by running the ```aws configure```

# Create a cluster with 2 nodes

eksctl create cluster \
--name demo-cluster \
--nodegroupe-name demo-cluster-nodes \
--region us-west-3\
--node-type t2.micro \
--nodes 2

# Delete the created cluster
eksctl delete cluster --name demo-cluster


# Template
aws configure  => allows you to set up your AWS credentials, region and output format

eksctl create cluster \
--name <name_of_cluster> \
--version <k8s_Version> \
--region <region> \
--nodegroup-name <nodegroup_name> \ => name of the nodegroup, nodes need to belong to a group
--node-type <node_type> \ => type of instance we want, for example t2.micro which is free tier eligible
--nodes <number_of_nodes> \ => number of nodes we want in the cluster

kubectl get nodes => to check if the nodes are up and running
kubectl get pods => to check if the pods are up and running

eksctl delete cluster --name <name_of_cluster> => to delete the cluster and all its resources



