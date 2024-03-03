#!/bin/bash

NAMESPACE="argocd"

if kubectl get namespace "$NAMESPACE" &> /dev/null; then
  echo "Namespace $NAMESPACE already exists."
else
  echo "Namespace $NAMESPACE does not exist. Creating..."
  kubectl create namespace "$NAMESPACE"
  echo "Namespace $NAMESPACE created."
fi
helm install argocd argo/argo-cd -n argocd -f node-port-values.yaml
sleep 5
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
kubectl get svc -n argocd
# kubectl apply -f repo-secret.yaml
# kubectl apply -f application.yaml
kubectl port-forward service/argocd-server -n argocd 8080:443
