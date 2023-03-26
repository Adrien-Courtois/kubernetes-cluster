# Docker
echo "######### Installation de docker #########"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - > /dev/null
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" > /dev/null
sudo apt-get update > /dev/null
sudo apt-get install -y docker-ce > /dev/null
sudo usermod -aG docker vagrant  > /dev/null
su - vagrant 

# Docker compose
echo "######### Installation de docker-compose #########"
sudo curl -sL https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose  > /dev/null
sudo chmod +x /usr/local/bin/docker-compose  > /dev/null

# Désactivation du swap
echo "######### Désactivation du swap #########"
swapoff -a
## Commenter la ligne de swap dans fstab
sudo sed -i '11 s/^/#/g' /etc/fstab

# Kubernetes (v1.14.1)
echo "######### installation de kubernetes #########"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - > /dev/null
sudo add-apt-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /dev/null
sudo apt-get update > /dev/null
sudo apt-get install --allow-downgrades -y kubernetes-cni=0.7.5-00 kubelet=1.14.1-00 kubeadm=1.14.1-00 kubectl=1.14.1-00 > /dev/null

# kubeadm join 192.168.56.101:6443 --token scf2x5.3j29eylq6jeuo6bs --discovery-token-ca-cert-hash sha256:eaefe0765b5b0f760fc03a52392b905e153970fc77d0887cabd7ee8cebfd495a