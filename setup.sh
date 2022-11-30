#!/bin/bash

# Installing and setting up Docker
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
systemctl start docker
systemctl enable docker
usermod -aG docker vagrant


# Installing Kubernetes
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-latest.x86_64.rpm
rpm -Uvh minikube-latest.x86_64.rpm ; rm minikube-latest.x86_64.rpm
sudo -u vagrant bash -c "minikube start --driver=docker"
# minikube config set driver docker
# minikube start


# Deploying basic hello-minikube app
minikube start
minikube addons enable ingress
minikube kubectl -- create deployment presentation --image=gcr.io/google-samples/hello-app:1.0
minikube kubectl -- expose deployment presentation --type=NodePort --port=5050
	
# Setup SSH copy for restore point
# tbf
ssh-keyscan akela.mendelu.cz >> ~/.ssh/known_hosts
chmod 644 ~/.ssh/known_hosts
# scp -r ~/.minikube/ xkollar3@akela.mendelu.cz:/home/xkollar3/k8s/
# scp -r xkollar3@akela.mendelu.cz:/home/xkollar3/k8s/.minikube/ ~/.
