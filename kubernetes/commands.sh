#!/bin/bash
echo "To create yml file from run command:"
kubectl run redis --image=redis --dry-run=client -o yaml > redis-definition.yaml
kubectl create -f redis-definition.yaml

echo "To edit replicaset:"
kubectl edit replicaset myapp-replicaset

echo "To scale using command instead of reconfig file:"
kubectl scale --replica=6 -f replicaset-definition.yml