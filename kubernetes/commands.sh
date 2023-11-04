#!/bin/bash
echo "To create yml file from run command:"
kubectl run redis --image=redis --dry-run=client -o yaml > redis-definition.yaml
kubectl create -f redis-definition.yaml

echo "To edit replicaset:"
kubectl edit replicaset myapp-replicaset

echo "To scale using command instead of reconfig file:"
kubectl scale --replica=6 -f replicaset-definition.yml

echo "To apply new config:"
kubectl apply -f replicaset-definition.yml

echo "To check rollout status, history:"
kubectl rollout status deployment/myapp-deployment
kubectl rollout history deployment/myapp-deployment

echo "To rollback the rollout:"
kubectl rollout undo deployment/myapp-deployment
