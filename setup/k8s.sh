#!/bin/bash

# Installing and setting up Docker
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
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
# Akela old, not a good idea
#
# ssh-keyscan akela.mendelu.cz >> ~/.ssh/known_hosts
# mkdir -p ~/.ssh/known_hosts ; chmod 644 ~/.ssh/known_hosts
# scp -r ~/.minikube/ xkollar3@akela.mendelu.cz:/home/xkollar3/k8s/
# scp -r xkollar3@akela.mendelu.cz:/home/xkollar3/k8s/.minikube/ ~/.

# Setting up Zabbix
# Disable Zabbix packages provided by EPEL
yes | cp /vagrant/zabbix/epel.repo /etc/yum.repos.d/epel.repo
    
rpm -Uvh https://repo.zabbix.com/zabbix/6.2/rhel/9/x86_64/zabbix-release-6.2-3.el9.noarch.rpm
dnf clean all 
   
dnf install -y man-pages chrony zabbix-agent2 zabbix-agent2-plugin-*


# SSH Configuration
runuser -l root -c "ssh-keygen -f '/root/.ssh/id_rsa' -N ''"
cp /root/.ssh/id_rsa.pub /vagrant/keys/
cp /vagrant/setup/initial-start.sh /usr/local/bin/
/usr/local/bin/initial-start.sh &
    

# Retrieving Zabbix configuration
cp /vagrant/zabbix/agent/key.psk /etc/zabbix/key.psk
yes | cp /vagrant/zabbix/agent/zabbix_agent2.conf /etc/zabbix/zabbix_agent2.conf
    
systemctl start chronyd zabbix-agent2
systemctl enable chronyd zabbix-agent2

# Set Timezone for logs
timedatectl set-timezone Europe/Prague

