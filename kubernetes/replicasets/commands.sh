#!/bin/bash
echo "To edit replicaset:"
kubectl edit replicaset myapp-replicaset

echo "To scale using command instead of reconfig file:"
kubectl scale --replica=6 -f replicaset-definition.yml

echo "To apply new config:"
kubectl apply -f replicaset-definition.yml