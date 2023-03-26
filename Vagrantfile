# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    
    ## Ajout de la clés SSH indiquer dans le fichier de configuration
    config.vm.provision "shell", inline: <<-SHELL
        echo #{File.readlines("/home/adrien/.ssh/id_rsa.pub").first.strip} >> /home/vagrant/.ssh/authorized_keys
    SHELL

    ## installation de docker
    config.vm.provision "shell", path: "install-provision.sh"
    
    config.vm.define "kubmaster" do |machine|
        machine.vm.box = "bento/ubuntu-16.04"
        machine.vm.hostname = "kubmaster"
        machine.vm.box_url = "bento/ubuntu-16.04"
        machine.vm.network :private_network, ip: "192.168.56.101"
        machine.vm.provider :virtualbox do |v|
            v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
            v.customize ["modifyvm", :id, "--memory", 2048]
            v.customize ["modifyvm", :id, "--name", "kubmaster"]
            v.customize ["modifyvm", :id, "--cpus", "2"]
        end
    end
     
    config.vm.define "kubnode" do |machine|
        machine.vm.box = "bento/ubuntu-16.04"
        machine.vm.hostname = "kubnode"
        machine.vm.box_url = "bento/ubuntu-16.04"
        machine.vm.network :private_network, ip: "192.168.56.102"
        machine.vm.provider :virtualbox do |v|
            v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
            v.customize ["modifyvm", :id, "--memory", 2048]
            v.customize ["modifyvm", :id, "--name", "kubnode"]
            v.customize ["modifyvm", :id, "--cpus", "2"]
        end
    end

end