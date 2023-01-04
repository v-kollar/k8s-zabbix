#!/bin/bash

# Download from the backup
#ssh-keygen -t rsa
#scp ~/.ssh/id_rsa.pub vagrant@192.168.10.10:/home/vagrant/.ssh/
#scp -r -o StrictHostKeyChecking=no vagrant@192.168.10.10:/home/vagrant/.minikube/ ~/home/vagrant/.


# https://alvinalexander.com/linux-unix/how-use-scp-without-password-backups-copy/
# https://stackoverflow.com/questions/1346509/automate-scp-file-transfer-using-a-shell-script
# ssh-copy-id ?

# Upload to backup server
#scp -o StrictHostKeyChecking=no -r .minikube/ vagrant@192.168.10.11:/home/vagrant/.minikube/

# Vycka 200 vterin, nez se spusti druhy server, a prida si jej do well-known hostu

FLAG="/var/log/firstboot.log"

if [[ ! -f $FLAG ]]; then
    sleep 180
    ssh-keyscan -H 192.168.10.11 >> /home/vagrant/.ssh/known_hosts
    ssh-keyscan -H 192.168.10.11 >> ~/.ssh/known_hosts
    
    #write out current crontab
    crontab -l > backup-event
    #echo new cron into cron file
    echo "*/2 * * * * /vagrant/backup.sh" >> backup-event
    #install new cron file
    crontab backup-event
    rm backup-event
   
   touch "$FLAG"
fi
