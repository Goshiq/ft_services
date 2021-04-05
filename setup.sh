#!/bin/bash

minikube delete
minikube start --driver=docker
eval $(minikube -p minikube docker-env)

#metallb
minikube addons enable metallb
minikube addons enable ingress
minikube addons enable metrics-server
minikube addons list

#kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
#kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
#kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f srcs/metallb.yaml

#get disk space
kubectl apply -f srcs/vol.yaml

#influxdb
docker build -t influxdb:jmogo ./srcs/influxdb/
kubectl apply -f srcs/influxdb.yaml

#mysql
docker build -t mysql:jmogo ./srcs/mysql/
kubectl apply -f srcs/mysql.yaml

#nginx
docker build -t nginx:jmogo ./srcs/nginx/
kubectl apply -f srcs/nginx.yaml

#wordpress
docker build -t wordpress:jmogo ./srcs/wordpress/
kubectl apply -f srcs/wordpress.yaml

#phpmyadmin
docker build -t phpmyadmin:jmogo ./srcs/pma/
kubectl apply -f srcs/pma.yaml

#ftps
docker build -t ftps:jmogo ./srcs/ftps/
kubectl apply -f srcs/ftps.yaml

#grafana
docker build -t grafana:jmogo ./srcs/grafana/
kubectl apply -f srcs/grafana.yaml

#launch dashboard
minikube dashboard
