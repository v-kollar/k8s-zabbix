scp -r /home/vagrant/* vagrant@192.168.10.11:/vagrant/backup/home/$(date +%Y%m%d_%H%M%S)
# scp -r /etc/raddb/* vagrant@192.168.10.11:/vagrant/backup/config/$text
scp -r /var/log/* vagrant@192.168.10.11:/vagrant/backup/logs/$(date +%Y%m%d_%H%M%S)
scp -r /data* vagrant@192.168.10.11:/vagrant/backup/data/$(date %Y%m%d_%H%M%S)
scp -r /var/lib/minikube* vagrant@192.168.10.11:/vagrant/backup/data/var/lib/minikube/$(date %Y%m%d_%H%M%S)
scp -r /var/lib/docker* vagrant@192.168.10.11:/vagrant/backup/data/var/lib/docker/$(date %Y%m%d_%H%M%S)
scp -r /var/lib/containerd vagrant@192.168.10.11:/vagrant/backup/data/var/lib/containerd/$(date %Y%m%d_%H%M%S)
