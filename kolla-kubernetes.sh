sudo kubeadm init --pod-network-cidr=10.1.0.0/16 --service-cidr=10.3.3.0/24

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


watch -d kubectl get pods --all-namespaces -o wide

# curl -L https://raw.githubusercontent.com/projectcalico/canal/master/k8s-install/1.6/rbac.yaml -o rbac.yaml
kubectl apply -f rbac.yaml

# curl -L https://raw.githubusercontent.com/projectcalico/canal/master/k8s-install/1.6/canal.yaml -o canal.yaml
# sed -i "s@10.244.0.0/16@10.1.0.0/16@" canal.yaml
kubectl apply -f canal.yaml

kubectl taint nodes --all=true  node-role.kubernetes.io/master:NoSchedule-

read -p "wait until 3 dns pods are up"
watch -d kubectl get pods --all-namespaces -o wide

read -p "run nslookup kubernetes after the following command, and then exit"
kubectl run -i -t $(uuidgen) --image=busybox --restart=Never

