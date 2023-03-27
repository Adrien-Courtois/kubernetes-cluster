# Initiation à Kubernetes

## Installation

Fait sur `Ubuntu 22.04 (Jammy)`

### Docker

Récupération keyring
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

Ajout du dépôt apt
```
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

Update et install de docker
```
sudo apt update
sudo apt install docker-ce
```

Configuration pour éviter les sudo répétitifs (vagrant est le user par défaut de vagrant)
```
sudo usermod -aG docker vagrant
```

### Swap off

Désactivation du swap
```
swapoff -a
```

Commenter la ligne du swap dans fstab
```
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
```

### Kubernetes

Ajout de la clé
```
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/kubernetes-xenial.gpg
```

Ajout du repository apt de kubernetes
```
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
```

Update et installation de kubernetes
```
sudo apt update
sudo apt install -y kubelet kubeadm kubectl
```

## Configuration

### Création du cluster `master`

Passage en root
```
sudo -s
```

Fix d'un bug avec containerd
```
rm -rf /etc/containerd/config.toml
sudo systemctl restart containerd
```

Création du cluster
```
kubeadm init --apiserver-advertise-address=192.168.56.101 --node-name $HOSTNAME --pod-network-cidr=10.244.0.0/16
```
 - `--apiserver-advertise-address` : correspond à l'adresse du master
 - `--node-name` : nom du noeud souhaité (ici on met le hostname du système)
 - `--pod-network-cidr=10.244.0.0/16` : CIDR block pour l'attribution d'adresse

On repasse en user standard
```
exit
```

On créer les fichiers de conf de kubernetes
```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

Maintenant on peux voir la master node dans le cluster
```
kubectl get nodes
```

### Join le cluster