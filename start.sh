#!/bin/bash
kubeadm init --apiserver-advertise-address $(hostname -i)
kubectl apply -n kube-system -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 |tr -d '\n')"
kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml
kubectl create -f https://raw.githubusercontent.com/rahgadda/Kubernetes/master/DashboardServiceAccount.yaml
kubectl -n kube-system edit service kubernetes-dashboard
	type: ClusterIP  [Change to]
	type: NodePort
kubectl describe serviceaccount kubernetes-dashboard -n kube-system
kubectl describe secrets kubernetes-dashboard-token-jkcz5 -n kube-system
kubeadm join --token 066971.62faa16446a54398 192.168.0.18:6443 --discovery-token-ca-cert-hash sha256:b5f18bb1c322616832af7c06560d307b19a2936a693649b32e2c2985d12c436c

