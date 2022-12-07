# Download from the backup
#ssh-keygen -t rsa
#scp ~/.ssh/id_rsa.pub vagrant@192.168.10.10:/home/vagrant/.ssh/
scp -r -o StrictHostKeyChecking=no vagrant@192.168.10.10:/home/vagrant/.minikube/ ~/home/vagrant/.


# https://alvinalexander.com/linux-unix/how-use-scp-without-password-backups-copy/
# https://stackoverflow.com/questions/1346509/automate-scp-file-transfer-using-a-shell-script
# ssh-copy-id ?

# Upload to backup server
scp -o StrictHostKeyChecking=no -r .minikube/ vagrant@192.168.10.11:/home/vagrant/.minikube/
