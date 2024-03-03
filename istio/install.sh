#!/bin/bash
#make sure that you have a cluster
kubectl cluster-info
wget https://raw.githubusercontent.com/colossus06/microservices-release/master/kubernetes-manifests.yaml

kubectl create ns istio-system
curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.20.3 TARGET_ARCH=x86_64 sh --
cd istio-1.20.3
export PATH=$PWD/bin:$PATH
istioctl x precheck

#prep requirements for CRDS
istioctl install --set profile=demo -y
kubectl label ns default istio-injection=enabled
#install kiali, jaeger, grafana, prometheus
k apply -f istio-1.20.3/samples/addons/


kubectl apply -f kubernetes-manifests.yaml

