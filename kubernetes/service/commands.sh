#!/bin/bash
echo "To create service"
kubectl create -f service-definition.yml
kubectl get services
minikube service myapp-service --url
curl http://192.168.1.2:30008