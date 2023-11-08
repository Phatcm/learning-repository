#!/bin/bash
kubectl create -f voting-app-deploy.yml
kubectl create -f voting-app-service.yml
kubectl create -f redis-deploy.yml
kubectl create -f redis-service.yml
kubectl create -f postgres-deploy.yml
kubectl create -f postgres-service.yml
kubectl create -f worker-app-deploy.yml
kubectl create -f result-app-deploy.yml
kubectl create -f result-app-service.yml