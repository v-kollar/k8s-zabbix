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


# TODO:
# Alias kubectl for minikube manipulation
echo -e '\nalias kubectl="minikube kubectl --"' >> ~/.bashrc
source ~/.bashrc
