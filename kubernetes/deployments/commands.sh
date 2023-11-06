#!/bin/bash
echo "To check rollout status, history:"
kubectl rollout status deployment/myapp-deployment
kubectl rollout history deployment/myapp-deployment

echo "To rollback the rollout:"
kubectl rollout undo deployment/myapp-deployment
