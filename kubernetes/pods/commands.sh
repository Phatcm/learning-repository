#!/bin/bash
echo "To create yml file from run command:"
kubectl run redis --image=redis --dry-run=client -o yaml > redis-definition.yaml
kubectl create -f redis-definition.yaml