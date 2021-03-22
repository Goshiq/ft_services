#!/bin/bash

minikube delete
minikube start --driver=docker
eval $(minikube -p minikube docker-env)

#metallb
minikube addons enable metallb
minikube addons list
#kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
#kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
#kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f srcs/metallb.yaml

#nginx
docker build -t nginx:jmogo ./srcs/nginx/
kubectl apply -f srcs/nginx.yaml

#mysql
docker build -t mysql:jmogo ./srcs/mysql/
kubectl apply -f srcs/mysql.yaml

#launch dashboard
minikube dashboard
