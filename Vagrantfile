Vagrant.configure("2") do |config|

  config.vm.box = "boxomatic/centos-stream-9"
   config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 4
   end

  config.vm.define "k8s" do |k8s|
    k8s.vm.hostname = "k8s"
    k8s.vm.box = "boxomatic/centos-stream-9"
    k8s.vm.network "private_network", ip: "192.168.10.10", virtualbox__intnet: true
    k8s.vm.network "forwarded_port", guest: 8001, host: 8001
    k8s.vm.provision "file", source: "./.bashrc", destination: ".bashrc"
    # k8s.vm.provision "shell", path: "setup_k8s.sh"
    k8s.vm.provision "shell", privileged: "true", path: "./setup/k8s.sh"
  end

  config.vm.define "zbx" do |zbx|
    zbx.vm.hostname = "zbx"
    zbx.vm.box = "boxomatic/centos-stream-9"
    zbx.vm.network "private_network", ip: "192.168.10.11", virtualbox__intnet: true
    zbx.vm.network "forwarded_port", guest: 80, host: 8080
    zbx.vm.provision "shell", privileged: "true", path: "./setup/zabbix.sh"
  end

end
