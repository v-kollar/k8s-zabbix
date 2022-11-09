Vagrant.configure("2") do |config|
  config.vm.box = "boxomatic/centos-stream-9"
   config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
   end
   config.vm.network "forwarded_port", guest: 8001, host: 8001
   config.vm.provision "file", source: "./.bashrc", destination: ".bashrc"
   config.vm.provision "shell", path: "setup.sh"
end
