#!/bin/bash

# SSH for backup to server
cat /vagrant/keys/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys


# Installation of Zabbix
# Disable Zabbix packages provided by EPEL
yes | cp /vagrant/zabbix/epel.repo /etc/yum.repos.d/epel.repo
    
rpm -Uvh https://repo.zabbix.com/zabbix/6.2/rhel/9/x86_64/zabbix-release-6.2-3.el9.noarch.rpm
dnf clean all 

# Installation of dependencies and immediate startup 
dnf install -y chrony httpd mariadb-server zabbix-server-mysql zabbix-web-mysql \
	             zabbix-apache-conf zabbix-sql-scripts zabbix-selinux-policy zabbix-agent       
systemctl start httpd mariadb zabbix-server zabbix-agent chronyd
systemctl enable httpd mariadb zabbix-server zabbix-agent chronyd

# Create database for Zabbix
/vagrant/setup/zabbix_mysql.sh
    
# Import of scheme for Zabbix database
zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -u zabbix -p password zabbix

# Set value of log-flag to 0 after startup
/vagrant/setup/disable_log.sh


# Upload our 
## configuration files
cp /vagrant/zabbix/zabbix_server.conf /etc/zabbix/zabbix_server.conf
cp /vagrant/zabbix/zabbix.conf.php /etc/zabbix/web/zabbix.conf.php
    
## database
mysql zabbix < /vagrant/database/zabbix_db.sql



systemctl restart zabbix-server zabbix-agent httpd php-fpm


timedatectl set-timezone Europe/Prague
