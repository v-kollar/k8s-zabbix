Vagrant.configure("2") do |config|
  config.vm.box = "boxomatic/centos-stream-9"
   config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
	  vb.cpus = 2
   end
   config.vm.provision "file", source: "./.bashrc", destination: ".bashrc"
   config.vm.provision "shell", path: "setup.sh"
end
