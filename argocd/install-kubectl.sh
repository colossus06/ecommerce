#!/bin/bash
#ensure that you have a running kubernetes cluster
kubectl create namespace argocd
kubectl apply -n argocd -f argo-install.yaml
sleep 10
kubectl apply -f repo-secret.yaml
kubectl apply -f application.yaml
sleep 25
# Get the secret in YAML format
secret=$(kubectl get secret argocd-initial-admin-secret -n argocd -o yaml | grep password | awk '{print $2}')
# Decode the base64 encoded password
password=$(echo $secret | base64 -d)
echo "ArgoCD password: $password"

#k port-forward -n argocd svc/argocd-server 8080:80

